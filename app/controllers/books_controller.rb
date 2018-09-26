class BooksController < ApplicationController
  
  get '/books' do
    if logged_in?
      @books = Book.all
      erb :'/books/books'
    else
      flash[:message] = "You must login to view this page."
      redirect to '/login'
    end
  end
  
  get '/books/new' do
    if logged_in?
    erb :'/books/new'
    else
      flash[:message] = "You must be logged in to add a new book to your ReadingList."
      redirect to '/login'
    end
  end

  post '/books' do
    if logged_in?
      if params["book"]["title"] == "" || params["book"]["author"] == ""
        flash[:message] = "Please fill in all required fields."
        redirect to '/books/new'
      else
        @user = current_user
        @book = Book.create(title: params["book"]["title"], author: params["book"]["author"], user_id: session[:user_id])
        if @book.save
          @user.books << @book
          redirect to '/books'
          # redirect to '/books/#{@book.id}' ???????
        else
          redirect to '/books/new'
        end
      end
    else
      redirect to '/login'
    end
  end

  get '/books/:id' do
    if logged_in?
      @book = Book.find_by(id: params[:id])
      erb :'/books/show'
    else
      flash[:message] = "You must be logged in to view this book."
      redirect to '/login'
    end
  end

  get '/books/:id/edit' do
    if logged_in?
      @book = Book.find_by(id: params[:id])
      if @book && @book.user == current_user
        erb :'/books/edit'
      else
        redirect to '/books'
      end
    else
      flash[:message] = "You must be logged in to edit your ReadingList."
      redirect to '/login'
    end
  end

  patch '/books/:id' do
    if logged_in?
      if params["book"]["title"] == "" || params["book"]["author"] == ""
        redirect to '/books/:id/edit'
      else
        @book = Book.find_by(id: params[:id])
        if @book && @book.user == current_user
          if @book.update(title: params["book"]["title"], author: params["book"]["author"])
            flash[:message] = "Book sucessfully updated."
            redirect to '/books'
          end
          else
            redirect to '/books'
          end
        end           
    else
      redirect to '/login'
    end
  end

  delete '/books/:id/delete' do
    if logged_in?
      @book = Book.find_by(id: params["id"])
      if @book && @book.user == current_user
        @book.destroy
      end
      flash[:message] = "Your book has been deleted."
      redirect to '/books'
    else
      redirect to '/login'
    end
  end
end
