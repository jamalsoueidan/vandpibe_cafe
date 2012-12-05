class CreateCities < ActiveRecord::Migration
  def change
    create_table :cities do |t|
      t.string :name, :latitude, :longitude, :color
      t.boolean :visible, :default => true
    end
  end
end
