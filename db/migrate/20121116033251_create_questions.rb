class CreateQuestions < ActiveRecord::Migration
  def change
    create_table :questions do |t|
      t.string :title
      t.text :body
      t.integer :category_id
      t.boolean :visible, :default => true
      t.boolean :anonymous, :default => false
      t.belongs_to :user
      t.timestamps
    end
  end
end
