class AddColumnsToLocations < ActiveRecord::Migration
  def change
    add_column :locations, :furniture_rating, :float, :default => 0.0
    add_column :locations, :waterpipe_rating, :float, :default => 0.0
    add_column :locations, :service_rating, :float, :default => 0.0
    add_column :locations, :mood_rating, :float, :default => 0.0
    
    add_column :locations, :television, :boolean, :default => false
    add_column :locations, :music, :boolean, :default => false
    add_column :locations, :football, :boolean, :default => false

    add_column :locations, :openings_time, :text  
    add_column :locations, :description, :text
  end
end
