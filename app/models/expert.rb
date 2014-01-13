class Expert < ActiveRecord::Base
  
  
  has_many :friendships, :dependent => :destroy
  has_many :friends, :through => :friendships
  has_many :inverse_friendships, :class_name => "Friendship", :foreign_key => "friend_id", :dependent => :destroy
  has_many :inverse_friends, :through => :inverse_friendships, :source => :expert
  
  has_many :tags
  
  def fullname
    "#{firstname} #{surname}"
  end
  
  
  
  
  
end
