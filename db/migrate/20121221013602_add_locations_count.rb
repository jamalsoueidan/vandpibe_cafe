class AddLocationsCount < ActiveRecord::Migration
  def up
    add_column :cities, :locations_count, :integer, :default => 0

    City.reset_column_information
    City.find(:all).each do |p|
      City.update_counters p.id, :locations_count => p.locations.length
    end
  end

  def down
    remove_column :cities, :locations_count
  end
end
