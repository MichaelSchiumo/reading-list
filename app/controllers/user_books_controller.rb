class UserBooksController < ApplicationController
  
  get '/user_books/new' do
     if logged_in?
       @books = Book.all.select{|book| !(current_user.books.include?(book))}
      erb :'user_books/new'
     else
      erb :'users/login'
     end
   end

  #  post '/user_books' do

  #  end
end

#user can add comments about books