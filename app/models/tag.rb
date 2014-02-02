class Tag < ActiveRecord::Base
  belongs_to :expert
  
  validates :expert, :presence => true
  validates :tag, :presence => true
  
  
  def self.search(term)
    puts term
    if (term)
      # get list of tags that meet criteria
      res = Tag.where('tag ILIKE ?', "%#{term}%")
      res.each do |t|
        # filter own tags and tags of friends
        if ($current_expert)
          if (t.expert_id == $current_expert.id || $current_expert.friends.include?(Expert.find(t.expert_id)))
            res.delete(t)
          end 
        end
      end
    else
      res = Tag.all
    end
    return res
  end
end
