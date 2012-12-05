class Brand < ActiveRecord::Base
  attr_accessible :name, :country, :description
  has_many :tobaccos
end
