class Rating < ActiveRecord::Base
  KEYS = ['vandpibe', 'service', 'indretning', 'social', ]
  
  attr_accessible :rating_key, :rating_value

  belongs_to :user
  belongs_to :location
end
