class Review < ApplicationRecord
  belongs_to :place
  validates :content, presence: true
end
