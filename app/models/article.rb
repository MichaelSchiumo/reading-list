class Article < ActiveRecord::Base
  belongs_to :user
  belongs_to :topic

  validates :title, presence: true
  validates :author, presence: true
  validates :url, presence: true

  def slug
    self.title.split(/\W/).join("-").downcase
  end

  def self.find_by_slug(slug)
    self.all.find do |article|
      article.slug == slug
    end
  end
end