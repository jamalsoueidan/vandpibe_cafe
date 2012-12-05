class CreateRatings < ActiveRecord::Migration
  def change
    create_table :ratings do |t|
      t.belongs_to :user
      t.integer :rating_id
      t.integer :rating_value
      t.string :rating_type, :rating_key
      t.timestamps
    end
  end
end
