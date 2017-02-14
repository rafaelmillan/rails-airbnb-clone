class AddPhotoToPlace < ActiveRecord::Migration[5.0]
  def change
    add_column :places, :photo, :string
  end
end
