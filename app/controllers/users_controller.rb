class UsersController < ApplicationController 
  
  get '/signup' do
    if logged_in?
      redirect "/users/#{@user.id}"
    else
      erb :'users/signup'
    end
  end

  post '/signup' do
    if !params["username"].empty? && !params["email"].empty? && !params["password"].empty?
      @user = User.create(params)
      session[:user_id] = @user.id
      flash[:message] = "You have successfully created a My ReadingList account."
      redirect "/users/#{@user.id}"
    else
      redirect '/signup'
    end
  end

  get '/login' do
    if logged_in?
      redirect "users/#{@user.id}"
    else
      erb :'users/login'
    end
  end

  post '/login' do
    @user = User.find_by(username: params[:username])
    if @user && @user.authenticate(params[:password])
      session[:user_id] = @user.id
      redirect '/books'
      # redirect "/users/#{session[:user_id]}"
      # redirect "users/#{@user.id}"
    else
      redirect '/login'
    end
  end

  get '/users/:id' do
    if logged_in?
      @user = User.find_by(id: session[:user_id])
      erb :'users/show'
    else
      redirect to '/login'
    end
  end

#   get '/users/:id' do
#     if logged_in?
#       @user = User.find_by(id: session[:user_id])

#       erb :'users/show'
#   else
#     redirect '/books'
#   end
# end

  get '/logout' do
    logout
    flash[:message] = "You are now logged out."
    redirect '/'
  end
end