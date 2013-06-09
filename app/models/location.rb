# -*- encoding : utf-8 -*-
class Location < ActiveRecord::Base
  attr_accessible :city_id, :name, :address, :post, :latitude, :longitude, :visible, :meta_title, :meta_description, :meta_keywords, :furniture_rating, :waterpipe_rating, :service_rating, :television, :music, :football, :openings_time, :description, :mood_rating

  has_and_belongs_to_many :tobaccos

  has_many :comments, :as => :commentable
  has_many :uploads, :as => :uploadable
  has_many :references
  has_many :ratings  do
    def calculate_by_key(rating_key=nil)
      calcalate(self.where(:rating_key => rating_key))
    end

    def calculate_all
      calcalate(self)
    end

    private
      def calcalate(objects)
        rating_value = 0
      
        objects.each do |r|
          rating_value += r.rating_value
        end
        
        if objects.empty?
          return 3
        else
          return (rating_value / objects.size).round(1)
        end
    end
  end

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

    def best_rating(sort_by=nil)
      sort_by.gsub!('bedste+', '') unless sort_by.nil?

      if sort_by == 'vandpibe'
        self.order('waterpipe_rating DESC').limit(10)
      elsif sort_by == 'service'
        self.order('service_rating DESC').limit(10)
      elsif sort_by == 'indretning'
        self.order('furniture_rating DESC').limit(10)
      elsif sort_by == 'stemning'
        self.order('mood_rating DESC').limit(10)
      else
        self.select('*, round(sum(mood_rating)+sum(service_rating)+sum(waterpipe_rating)+sum(furniture_rating), 3) as total').group('id').order('total desc').includes(:comments).limit(10)
      end
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