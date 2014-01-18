class Friendship < ActiveRecord::Base
  belongs_to :expert
  belongs_to :friend, :class_name => "Expert"
  
  #validates_uniqueness_of :expert, :scope => :friend
  
  validates :expert_id, :presence => true
  validates :friend_id, :presence => true
  
  
end
