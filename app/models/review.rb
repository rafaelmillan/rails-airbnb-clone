class Review < ApplicationRecord
  RATING = (1..5)
  belongs_to :place
  validates :content, presence: true
  validates :rating, presence: true, inclusion: { in: RATING, allow_nil: false }, numericality: {only_integer: true }
end
