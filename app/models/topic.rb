class Topic < ActiveRecord::Base
  has_many :users, through: :books
  has_many :books

end