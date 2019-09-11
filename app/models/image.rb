class Image < ApplicationRecord
  validates :url, format: { with: /(http(s?):)(.)*\.(?:jpg|gif|png)/, message: 'Not an image url' }
end
