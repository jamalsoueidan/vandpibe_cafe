# -*- encoding : utf-8 -*-
class Location < ActiveRecord::Base
  attr_accessible :city_id, :name, :address, :post, :latitude, :longitude, :visible, :meta_title, :meta_description, :meta_keywords, :furniture_rating, :waterpipe_rating, :service_rating, :television, :music, :football, :openings_time, :description, :mood_rating

  has_and_belongs_to_many :tobaccos
    
  has_many :comments, :as => :commentable
  has_many :uploads, :as => :uploadable
  has_many :references

  belongs_to :city
  
  #default_scope :order => "name ASC"
  
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
    'En lille beskrivelse af vandpibe cafeen vil komme så snart vi har besøgt cafeen.'
  end
end
