class CreateProducts < ActiveRecord::Migration
  def change
    create_table :products do |t|
    	t.string :title, :brand, :short_desc
    	t.text :long_desc
    	t.integer :price, :stock
    	t.belongs_to :variant
      	t.timestamps
    end
  end
end
