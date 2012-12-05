class Upload < ActiveRecord::Base
  attr_accessible :avatar, :uploadable_type, :uploadable_id, :title 
  has_attached_file :avatar, :styles => { :medium => "300x300>", :thumb => "100x100>" }
  belongs_to :uploadable, :polymorphic => true
end
