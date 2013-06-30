class Country < ActiveRecord::Base
	has_many :cities, -> { where visible: true }

	default_scope {
    	order('name asc')
  	}
end
