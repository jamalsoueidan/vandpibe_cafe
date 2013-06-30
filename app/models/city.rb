class City < ActiveRecord::Base
  #attr_accessible :name, :latitude, :longitude, :visible, :color, :meta_title, :meta_description, :meta_keywords, :country_id

  belongs_to :country 
  
  default_scope {
    where(:visible => true).order('name asc')
  }

  has_many :locations do
    def include_all
      self.includes(:city, :comments => [:user], :tobaccos => :brand)
    end
  end

  def seo_title
    self[:name].titleize
  end

  def seo_name_url
    self[:name].gsub(' ', '+')
  end
end