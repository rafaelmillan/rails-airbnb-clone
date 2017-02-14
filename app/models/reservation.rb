class Reservation < ApplicationRecord
  belongs_to :user
  belongs_to :place
  validates :user, presence: true
  validates :place, presence: true

  def accept
    self.status = "accepted"
    save
  end

  def decline
    self.status = "declined"
    save
  end
end
