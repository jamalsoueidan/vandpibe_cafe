# -*- encoding : utf-8 -*-
class Location < ActiveRecord::Base
  #attr_accessible :city_id, :name, :address, :post, :latitude, :longitude, :visible, :meta_title, :meta_description, :meta_keywords, :furniture_rating, :waterpipe_rating, :service_rating, :television, :music, :football, :openings_time, :description, :mood_rating
  
  has_and_belongs_to_many :tobaccos

  has_many :comments, :as => :commentable
  has_many :uploads, :as => :uploadable
  has_many :references
  has_many :ratings

  class << self
    def sort_by(name=nil)
      query = select('locations.*, COALESCE(r.average, 0) as rating, COALESCE(r.count, 0) as count')
      query = query.joins('LEFT JOIN (SELECT location_id, COUNT(location_id) as count, AVG(rating_value) as average FROM ratings GROUP BY location_id) r ON r.location_id=locations.id')
      if name.nil?
        query.order('locations.name ASC')
      else
        query.order('rating DESC')
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

  belongs_to :city, :counter_cache => true

  RATING_KEYS = [:location_service, :location_waterpipe, :location_furniture, :location_mood]

  def seo_title
    (self[:name] + "Vandpibe Cafe").titleize
  end

  def seo_name_url
    self[:name]
  end

end
