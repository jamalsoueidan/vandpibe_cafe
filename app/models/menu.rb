class Menu < ActiveRecord::Base
  #attr_accessible :name, :link
  has_and_belongs_to_many :locations
end
