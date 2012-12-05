class CreateTobaccos < ActiveRecord::Migration
  def change
    create_table :tobaccos do |t|
      t.string :name, :rating
      t.belongs_to :brand
    end
  end
end
