class UserBooksController < ApplicationController
  
  get '/user_books/new' do
    if logged_in?
      @books = Book.all.select{|book| !(current_user.books.include?(book))}
      erb :'user_books/new'
    else
      erb :'users/login'
    end
  end

  post '/user_books/new' do

  end

  get '/user_books/:id/edit' do
    if logged_in? && @user_book = UserBook.find_by_id(params[:id])
      erb :'user_books/edit'
    else
      redirect "/users/#{@user.id}"
    end
  end

  patch '/book_list_items/:id' do
    comment = UserBook.find_by_id(params[:id])
    if comment.user_id == current_user.user_id
      comment.update(params[:user_book])
      redirect "/users/#{@user.id}"
    else
      redirect "/users/#{@user.id}"
    end
  end

  delete '/user_books/:id/delete' do
    comment = UserBook.find_by_id(params[:id])
    if comment.user_id == current_user.user_id
      comment.destroy
      redirect "/users/#{@user.id}"
    else
      redirect "/users/#{@user.id}"
    end
  end

end

