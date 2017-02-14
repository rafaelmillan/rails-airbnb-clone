class ChangeColumnStatusInReservations < ActiveRecord::Migration[5.0]
  def change
    change_column_default :reservations, :status, "pending"
  end
end
