class Product < ActiveRecord::Base
  #attr_accessible :title, :brand, :short_desc, :long_desc, :price, :stock, :variant_id
  belongs_to :variant
  has_many :uploads, :as => :uploadable
end
