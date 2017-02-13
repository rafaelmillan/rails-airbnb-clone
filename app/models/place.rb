class Place < ApplicationRecord
  belongs_to :user
  has_many :reservations, dependent: :destroy
  validates :name, presence: true
  validates :description, presence: true
  validates :address, presence: true
  validates :price, presence: true
end
