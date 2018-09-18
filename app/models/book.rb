class Book < ActiveRecord::Base
  belongs_to :user
  belongs_to :topics

  # validates :title, presence: true
  # validates :author, presence: true
  # validates :url, presence: true

  def slug
    self.title.split(/\W/).join("-").downcase
  end

  def self.find_by_slug(slug)
    self.all.find do |book|
      book.slug == slug
    end
  end
end