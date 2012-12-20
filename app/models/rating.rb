class Rating < ActiveRecord::Base
  belongs_to :rating, :polymorphic => true
  belongs_to :user
  attr_accessible :rating_key, :user_id, :rating_value
  validates_uniqueness_of :rating_key, :scope => [:user_id, :rating_type, :rating_id]
  
  def self.average_by_key(value, ids, table)
    Rating.average(:rating_value, :conditions => ['rating_key = ? AND rating_id IN (?) AND rating_type = ?', value, ids, table])
  end
  
  def has_rated?(user, options={})
    options['rating.user_id'] = user.id
    self.exists?(options)
  end
end
