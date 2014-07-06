class AddCityColumnToLocation < ActiveRecord::Migration
  def change
    add_column :locations, :city, :string
    add_column :locations, :country, :string

    City.all.each do |city|
      city.locations.each do |location|
        if place = location.post.strip.index(' ')
          location.update_attribute(:post, location.post.strip[0..(place-1)])
        end
        location.update_attributes(:city => city.name.downcase, :country => city.country.name.downcase)
      end
    end
  end
end
