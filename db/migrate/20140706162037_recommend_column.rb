class RecommendColumn < ActiveRecord::Migration
  def change
    add_column :locations, :recommend, :boolean, :default => false
    rename_column :locations, :country, :country_code
  end
end
