class CreateLocationsMenus < ActiveRecord::Migration
  def change
    create_table :locations_menus, :id => false do |t|
      t.belongs_to :menu
      t.belongs_to :location
    end
  end
end
