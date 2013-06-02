class CreateRatings < ActiveRecord::Migration
  def change
  	drop_table :ratings if self.table_exists?("ratings")

    create_table :ratings do |t|
    	t.belongs_to :user
    	t.belongs_to :location
    	t.string :rating_key
    	t.float :rating_value
      	t.timestamps
    end

    add_index(:ratings, :location_id)
    add_index(:ratings, :user_id)
  end
end
