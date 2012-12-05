class CreateLocations < ActiveRecord::Migration
  def change
    create_table :locations do |t|
      t.string :name, :address, :post, :latitude, :longitude
      t.boolean :visible, :default => true
      t.belongs_to :city
    end
  end
end
