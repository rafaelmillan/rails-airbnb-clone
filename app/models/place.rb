class Place < ApplicationRecord
  belongs_to :user
  has_many :reviews, dependent: :destroy
  has_many :reservations, dependent: :destroy
  validates :name, presence: true
  validates :description, presence: true
  validates :address, presence: true
  validates :price, presence: true
  validates :photo, presence: true
  mount_uploader :photo, PhotoUploader

  def rating
    self.reviews.average(:rating).to_i
  end
end
