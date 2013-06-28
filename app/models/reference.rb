class Reference < ActiveRecord::Base
  #attr_accessible :name, :link, :location_id
  belongs_to :location
end
