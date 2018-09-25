class BooksController < ApplicationController
  
  get '/books' do
    if logged_in?
      @books = Book.all
      erb :'/books/index'
    else 
      redirect to '/login'
    end
  end
  
  get '/books/new' do
    if logged_in?
    erb :'books/new'
    else
      flash[:message] = "You must be logged in to add a new book to your ReadingList."
      redirect '/login'
    end
  end

  get '/books/:id' do
    if logged_in?
      @user = User.find_by(id: session[:user_id])
      @book = Book.find_by(id: params["id"])
      erb :'/books/show'
    else
      flash[:message] = "You must be logged in to view this book."
      redirect '/login'
    end
  end

  get '/books/:id/edit' do
    if logged_in?
      @book = Book.find_by(id: params["id"])
      erb :'/books/edit'
    else
      flash[:message] = "You must be logged in to edit your ReadingList."
      redirect '/login'
    end
  end

  post '/books' do
    if params[:title] == "" || params[:author_name] == ""
      flash[:message] = "Please fill in all required fields."
      redirect '/books/new'
    else
      @user = User.find_by(id: session[:user_id])
      @book = Book.find_or_create_by(title: params["book"]["title"], author: params["book"]["author"])
      @book.save
      redirect "/books/#{@book.id}"
    end
  end

  patch '/books/:id' do
    @user = User.find_by(id: session[:user_id])
    @book = Book.find_by(id: params["id"])
    @book.update(title: params["title"], author: params["author"])
    flash[:message] = "Book sucessfully updated."
    redirect "/users/#{@user.id}"
  end

  delete '/books/:id/delete' do
    @user = User.find_by(id: session[:user_id])
    @book = Book.find_by(id: params["id"])
    @book.destroy
    flash[:message] = "Your book has been deleted."
    redirect "/users/#{@user.id}"
  end
end
