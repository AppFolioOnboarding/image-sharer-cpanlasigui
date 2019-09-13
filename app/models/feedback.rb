class Feedback < ApplicationRecord
  validates :name, :comment, presence: true
end
