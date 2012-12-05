class CreateUploads < ActiveRecord::Migration
  def change
    create_table :uploads do |t|
      t.attachment :avatar
      t.string :title
      t.integer :uploadable_id
      t.string :uploadable_type
      t.timestamps
    end
  end
end
