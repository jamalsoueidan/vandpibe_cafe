class CreateReferences < ActiveRecord::Migration
  def change
    create_table :references do |t|
      t.string :name, :link
      t.integer :location_id
    end
  end
end
