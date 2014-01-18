class Friendship < ActiveRecord::Base
  belongs_to :expert
  belongs_to :friend, :class_name => "Expert"
  
  #validates_uniqueness_of :expert, :scope => :friend
  
  validates :expert_id, :presence => true
  validates :friend_id, :presence => true
  
  def self.request(expert, friend)
    if (expert == friend)
      false
    else
      if (expert.friendships.build(:friend_id => friend.id).save &&
      expert.inverse_friendships.build(:expert_id => friend.id).save)
        true
      else
        false
      end
    end
  end
  
  
end
