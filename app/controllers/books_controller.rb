class BooksController < ApplicationController
  
  get '/books/new' do
    if logged_in?
    erb :'books/new'
    else
      flash[:message] = "You must be logged in to add a new book to your ReadingList."
      redirect '/books'
    end
  end

  get '/books' do
    @books = Book.all
    erb :'/books/index'
  end

  get '/books/:id' do
    if logged_in?
      @user = User.find_by(id: session[:user_id])
      @book = Book.find_by(id: params["id"])

      erb :'/books/show'
    else
      flash[:message] = "You must be logged in to view this book."
      redirect '/books'
    end
  end

  get '/books/:id/edit' do
    if logged_in?
      @book = Book.find_by(id: params["id"])
      erb :'/books/edit'
    else
      flash[:message] = "You must be logged in to edit your ReadingList."
      redirect '/books'
    end
  end

  post '/books' do
    if !params["author"].empty? && !params["title"].empty?
      @user = User.find_by(id: session[:user_id])
      @book = Book.find_or_create_by(title: params["title"], author: params["author"], topic_id: params["topic_id"], user_id: session[:user_id])

      flash[:message] = "You just added a new bookto your ReadingList."
      redirect "/users/#{@user.id}"
    else
      flash[:message] = "Please fill in all required fields."
      redirect '/books/new'
    end
  end

  patch '/books/:id' do
    @user = User.find_by(id: session[:user_id])
    @book = Book.find_by(id: params["id"])
    @book.update(title: params["title"], author: params["author"], topic_id: params["topic_id"])

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

#not sure about topic_id vs topic