class Expert < ActiveRecord::Base
  
  validates :firstname, :presence => true
  validates :surname, :presence => true
  validates :long_website, :presence => true
  
  has_many :friendships, :dependent => :destroy
  has_many :friends, :through => :friendships
  has_many :inverse_friendships, :class_name => "Friendship", :foreign_key => "friend_id", :dependent => :destroy
  has_many :inverse_friends, :through => :inverse_friendships, :source => :expert
  
  has_many :tags, :dependent => :destroy
  
  def set
    $current_expert = self
  end
  
  def fullname
    "#{firstname} #{surname}"
  end
  def check_site(site)
    begin
      doc = Nokogiri::HTML.parse(open(site))
    rescue Exception => e
      self.errors.add(:long_website, 'Website invalid - must follow the form: example.com & be a real website')
      self.website = nil
      #self.long_website = nil
      return false
    end
    return doc
  end
  
  def get_tags(doc)
    doc.css('h1, h2, h3').each do |tag|
          Tag.create(:expert_id => self.id, :tag => tag.inner_html)
          
          end
  end
  
  def remove_old_tags
    Tag.where(:expert_id => self.id).each do |tag|
      tag.destroy
    end
  end
  
  def shorten_site(site)
    googl = Shortly::Clients::Googl
        return googl.shorten(site).shortUrl
  end
 
  def web_check(site)
    prep = "http://"
  
    self.website = nil
    self.long_website = nil
    self.website = prep + site
    if (doc = check_site(self.website))
      self.long_website = site
      self.save
      if (Tag.where(:expert_id => self.id).first)
        remove_old_tags
      end
      get_tags(doc)
      
      self.update(:website => shorten_site(self.website))
      
      return true
    else
      return false
    end  
  end
  
  
  
  
  
end
