class CreateComments < ActiveRecord::Migration
  def change
    create_table :comments do |t|
      t.text :body
      t.belongs_to :user
      t.boolean :visible, :default => true
      t.integer :commentable_id
      t.string :commentable_type
      t.boolean :anonymous, :default => false
      t.timestamps
    end
  end
end
