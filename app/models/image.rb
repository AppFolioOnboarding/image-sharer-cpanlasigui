class Image < ApplicationRecord
  acts_as_taggable
  validates :url, format: { with: /(http(s?):)(.)*\.(?:jpg|gif|png)/, message: 'Not an image url' }
end
