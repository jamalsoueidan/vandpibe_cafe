class RemoveColumnsFromLocationsTable < ActiveRecord::Migration
  def change
  	remove_column :locations, :furniture_rating
    remove_column :locations, :waterpipe_rating
    remove_column :locations, :service_rating
    remove_column :locations, :mood_rating

    add_column :locations, :rating, :float, :default => 0.0
  end
end
