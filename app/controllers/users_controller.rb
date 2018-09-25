class UsersController < ApplicationController 
  
  get '/users/:id' do
    if logged_in?
      @user = User.find_by(id: session[:user_id])
      erb :'users/show'
    else
      redirect to '/login'
    end
  end
  
  get '/signup' do
    if !logged_in?
      erb :'users/signup'
    else
      redirect to '/books'
    end
  end

  post '/signup' do
    if params[:username] == "" || params[:email] == "" || params[:password] == ""
      redirect to '/signup'
    else
      @user = User.new(:username => params[:username], :email => params[:email], :password => params[:password])
      @user.save
      session[:user_id] = @user.id
      flash[:message] = "You have successfully created a My ReadingList account."
      redirect to '/books'
    end
  end

  get '/login' do
    if !logged_in?
      erb :'users/login'
    else
      redirect to '/books'
    end
  end

  post '/login' do
    user = User.find_by(:username => params[:username])
    if user && user.authenticate(params[:password])
      session[:user_id] = user.id
      redirect to '/books'
    else
      redirect to '/signup'
    end
  end

  get '/logout' do
    if logged_in?
      session.destroy
      flash[:message] = "You are now logged out."
      redirect to '/login'
    else
      redirect '/'
    end
  end
end