class Tobacco < ActiveRecord::Base
  attr_accessible :name, :rating, :brand_id, :location_ids
  belongs_to :brand
  has_and_belongs_to_many :locations
  default_scope :order => "brand_id, name DESC"
end
