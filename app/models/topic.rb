class Topic < ActiveRecord::Base
  has_many :users, through: :books
  has_many :users, through: :articles
  has_many :books
  has_many :articles

  validates :name, presence: true
end