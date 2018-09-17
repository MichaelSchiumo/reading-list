class Topic < ActiveRecord::Base
  has_many :books, through: :users
  has_many :articles, through: :users
end