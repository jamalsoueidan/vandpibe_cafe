class City < ActiveRecord::Base
  attr_accessible :name, :latitude, :longitude, :visible, :color, :meta_title, :meta_description, :meta_keywords
  has_many :locations
  
  def seo_title
    self[:name].titleize
  end
  
  def seo_name_url
    self[:name].gsub(' ', '+')
  end
end
