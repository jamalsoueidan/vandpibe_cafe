# -*- encoding : utf-8 -*-
class Location < ActiveRecord::Base
  attr_accessible :city_id, :name, :address, :post, :latitude, :longitude, :visible, :meta_title, :meta_description, :meta_keywords, :furniture_rating, :waterpipe_rating, :service_rating, :television, :music, :football, :openings_time, :description, :mood_rating

  has_and_belongs_to_many :tobaccos
    
  has_many :comments, :as => :commentable
  has_many :uploads, :as => :uploadable
  has_many :references

  belongs_to :city, :counter_cache => true
  
  RATING_KEYS = [:location_service, :location_waterpipe, :location_furniture, :location_mood]
  
  def self.best_rating
    select('*, round(sum(mood_rating)+sum(service_rating)+sum(waterpipe_rating)+sum(furniture_rating), 3) as total').group('id').order('total desc').includes(:comments).limit(10)
  end
  
  def seo_title
    (self[:name] + "Vandpibe Cafe").titleize
  end
  
  def seo_name_url
    self[:name]
  end
  
  def description
    return self[:description] unless self[:description] == '' || self[:description].nil?
    'Et kort beskriveles af cafeen vil komme på et tidspunkt :-)'
  end
  
  def user_ratings
    ratings = {}
    RATING_KEYS.each do |key|
      ratings[key] = Rating.average_by_key(key.to_s, comment_ids, 'Comment')
    end
    return ratings
  end
end
