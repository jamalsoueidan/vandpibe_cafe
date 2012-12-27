class City < ActiveRecord::Base
  attr_accessible :name, :latitude, :longitude, :visible, :color, :meta_title, :meta_description, :meta_keywords

  default_scope :order => 'name asc'

  has_many :locations, :order => 'name asc' do
    def include_all
      self.includes(:city, :comments => [:user, :ratings], :tobaccos => :brand)
    end
  end

  def seo_title
    self[:name].titleize
  end

  def seo_name_url
    self[:name].gsub(' ', '+')
  end
end
