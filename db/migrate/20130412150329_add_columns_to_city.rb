class AddColumnsToCity < ActiveRecord::Migration
  def change
    add_column :cities, :country_id, :integer

    City.all.each do |c|
    	c.update_attribute(:country_id, Country.first)
    end
  end
end
