class Book < ActiveRecord::Base
  belongs_to :user

#   def slug
#     self.title.split(/\W/).join("-").downcase
#   end

#   def self.find_by_slug(slug)
#     self.all.find do |book|
#       book.slug == slug
#     end
#   end
end