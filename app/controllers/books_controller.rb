class BooksController < ApplicationController
  
  get '/books' do
    redirect_if_not_logged_in
    @books = Book.all
    erb :'/books/books'
  end
  
  get '/books/new' do
    redirect_if_not_logged_in
    erb :'/books/new'
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
        else
          redirect to '/books/new'
        end
      end
    else
      redirect to '/login'
    end
  end

  get '/books/:id' do
    redirect_if_not_logged_in
    @book = Book.find_by(id: params[:id])
    erb :'/books/show'
  end

  get '/books/:id/edit' do
    redirect_if_not_logged_in
    @book = Book.find_by(id: params[:id])
    if @book && @book.user == current_user
      erb :'/books/edit'
    else
      redirect to '/books'
    end
  end

  patch '/books/:id' do
  redirect_if_not_logged_in
    if params["book"]["title"] == "" || params["book"]["author"] == ""
      redirect to '/books/:id/edit'
    else
      @book = Book.find_by(id: params[:id])
      if @book && @book.user == current_user
        if @book.update(title: params["book"]["title"], author: params["book"]["author"])
          flash[:message] = "Book sucessfully updated."
          redirect to '/books'
        else
          redirect to '/books'
        end
      end    
    end
  end

  delete '/books/:id/delete' do
    redirect_if_not_logged_in
    @book = Book.find_by(id: params["id"])
      if @book && @book.user == current_user
        @book.destroy
      end
    flash[:message] = "Your book has been deleted."
    redirect to '/books'
  end
end
