class Topic < ActiveRecord::Base
  has_many :users, through: :books
  has_many :books

  # validates :name, presence: true
end