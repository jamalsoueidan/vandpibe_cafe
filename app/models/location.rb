# -*- encoding : utf-8 -*-
class Location < ActiveRecord::Base
  #attr_accessible :city_id, :name, :address, :post, :latitude, :longitude, :visible, :meta_title, :meta_description, :meta_keywords, :furniture_rating, :waterpipe_rating, :service_rating, :television, :music, :football, :openings_time, :description, :mood_rating

  has_and_belongs_to_many :tobaccos

  has_many :comments, :as => :commentable
  has_many :uploads, :as => :uploadable
  has_many :references
  has_many :ratings

  scope :by_country, -> country { where(country: country) }
  scope :by_city, -> country { where(city: city) }
  scope :visible, -> { where(visible: true) }

  class << self
    def sort_by(name=nil)
      if name.nil?
        self.order('locations.name ASC')
      else
        self.order('rating DESC')
      end
    end
  end

  def average_rating
    result = ratings.average(:rating_value)
    if result.nil?
      return 2.5
    else
      return result
    end
  end

  def rating
    return 3.0 if self[:rating] == 0.0
    self[:rating]
  end

  RATING_KEYS = [:location_service, :location_waterpipe, :location_furniture, :location_mood]

  def seo_title
    (self[:name] + "Vandpibe Cafe").titleize
  end

  def seo_name_url
    self[:name]
  end

end
