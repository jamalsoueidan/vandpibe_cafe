# -*- encoding : utf-8 -*-
class Question < ActiveRecord::Base
  #attr_accessible :title, :body, :category, :anonymous
  attr_accessor :category
  belongs_to :user
  has_many :comments, :as => :commentable
  has_many :ratings, :as => :rating
  
  def to_param
    "#{id}/#{title.parameterize}"
  end
  
  def category
    if self[:category].nil?
      return CATEGORIES[self.category_id] unless self.category_id.nil?
    end
    return self[:category]
  end
  

  validates :body, :title, :presence => {:message => ""}
  
  CATEGORIES = ['Generalt', 'Vandpiber', 'Tobak', 'Tilbehør', 'Andet', 'Om VandpibeCafe.dk']
end
