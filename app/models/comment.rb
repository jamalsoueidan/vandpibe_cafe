class Comment < ActiveRecord::Base
  attr_accessible :body, :table, :table_id,  :rate_service, :rate_furniture, :rate_waterpipe, :rate_mood, :anonymous
  attr_accessor :table, :table_id, :rate_service, :rate_furniture, :rate_waterpipe, :rate_mood
  belongs_to :commentable, :polymorphic => true
  belongs_to :user
  belongs_to :location, :foreign_key => "commentable_id", :foreign_type => 'Location'
  validates :body, :presence => true
  
  has_many :ratings, :as => :rating, :dependent => :destroy do
    def by(rating_key)
      where(:rating_key => rating_key).first
    end
  end
end
