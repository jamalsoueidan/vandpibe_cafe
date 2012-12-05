class CreateLocationsTobaccos < ActiveRecord::Migration
  def change
    create_table :locations_tobaccos, :id => false do |t|
      t.belongs_to :tobacco
      t.belongs_to :location
      t.timestamps
    end
  end
end
