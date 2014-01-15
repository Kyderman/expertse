class Expert < ActiveRecord::Base
  
  validates :firstname, :presence => true
  validates :surname, :presence => true
  validates :website, :presence => true
  
  has_many :friendships, :dependent => :destroy
  has_many :friends, :through => :friendships
  has_many :inverse_friendships, :class_name => "Friendship", :foreign_key => "friend_id", :dependent => :destroy
  has_many :inverse_friends, :through => :inverse_friendships, :source => :expert
  
  has_many :tags, :dependent => :destroy
  
  def fullname
    "#{firstname} #{surname}"
  end
  
  def web_check
    prep = "http://"
    self.website = prep + self.website
    begin
      doc = Nokogiri::HTML.parse(open(self.website))
    rescue Exception => e
      self.errors.add(:website, 'Website invalid - must follow the form: example.com & be a real website')
      self.website = nil
      return false
    end
    self.save
    doc.css('h1, h2, h3').each do |tag|
          t  = Tag.create(:expert_id => self.id, :tag => tag.inner_html)
          
          end
        
        googl = Shortly::Clients::Googl
        self.update(:website => googl.shorten(self.website).shortUrl)
        return true
    
          
          
        
        
  end
  
  
  
  
  
end
