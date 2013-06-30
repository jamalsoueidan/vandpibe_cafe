class DropTables < ActiveRecord::Migration
  def change
  	drop_table :questions
  end
end
