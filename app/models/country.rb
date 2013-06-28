class Country < ActiveRecord::Base
	has_many :cities, :conditions => {:visible => true}
	#attr_accessible :name, :color
end
