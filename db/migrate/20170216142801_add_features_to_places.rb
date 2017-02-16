class AddFeaturesToPlaces < ActiveRecord::Migration[5.0]
  def change
    add_column :places, :UV, :boolean, default: false, null: false
    add_column :places, :startlight, :boolean, default: false, null: false
    add_column :places, :satellite, :boolean, default: false, null: false
    add_column :places, :wifi, :boolean, default: false, null: false
    add_column :places, :earth_mailing, :boolean, default: false, null: false
    add_column :places, :astronaut_outfit, :boolean, default: false, null: false
    add_column :places, :crater, :boolean, default: false, null: false
    add_column :places, :freezing, :boolean, default: false, null: false
    add_column :places, :alien, :boolean, default: false, null: false
    add_column :places, :detox, :boolean, default: false, null: false
  end
end
