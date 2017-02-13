class CreateReservations < ActiveRecord::Migration[5.0]
  def change
    create_table :reservations do |t|
      t.references :user, foreign_key: true
      t.references :place, foreign_key: true

      t.timestamps
    end
  end
end
