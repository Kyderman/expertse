class Expert < ActiveRecord::Base
  
  validates :firstname, :presence => true
  validates :surname, :presence => true
  validates :long_website, :presence => true
  
  has_many :friendships, :dependent => :destroy
  has_many :friends, :through => :friendships
  has_many :inverse_friendships, :class_name => "Friendship", :foreign_key => "friend_id", :dependent => :destroy
  has_many :inverse_friends, :through => :inverse_friendships, :source => :expert
  
  has_many :tags, :dependent => :destroy
  
  
  
  
  
  
  def self.get_friend_path(avoid, current, friend)
    puts 'CURRENT ARRAY'
    self.puts_array(current)
    puts 'AVOID ARRAY'
    self.puts_array(avoid)
    
    puts friend.fullname + ' FRIEND'
    puts current.last.fullname + ' CURRENT_EXPERT'
    if(!friend.friends.empty?)
      if(!current.empty?)
        if(!current.last.friends.include?(friend))
          current.last.friends.each do |fr|
            puts fr.fullname + ' in loop'
            # SKIP FRIENDS ALREADY SEARCHED
            if(avoid.include?(fr))
              next
            else
              # NOT AVOIDED + NOT WHAT WE WANT, THEREFORE SEARCH THEIR FRIENDS
              puts 'GOING TO NEXT'
              # WE NOW WANT TO AVOID THIS PERSON
              avoid.push(fr)
              # THIS PERSON IS PART OF OUR CURRENT PATH
              current.push(fr)
              # check this persons friends to see if we can get our answer
              if(@cur = get_friend_path(avoid, current, friend))
                puts 'ANSWER FOUND -  RESURSE TRUE'
                # if true, then we have our answer.
                return @cur
              else #false
                # no longer in our path
                puts fr.fullname + ' REMOVED, NOT IN PATH'
                current.delete(fr)
                next
              end
            end
          end    
        else
          # found path to friend
          puts 'found ' + friend.fullname
          puts 'RESULT'
          puts_array(current.push(friend))
          return current
        end
      else
        return false
      end    
    end
      return false
  end
  
  
  def self.print_results(array)
    if(array)
      @output = ""
      array.each do |ex|
        @output += ex.fullname
        if(array.last != ex)
          @output += ' => '
        end
      end
      return @output
    else
    return 'no path found'
    end
  end
  
  def self.puts_array(array)
    
      array.each do |ex|
        puts ex.fullname
      end
     
  end
  
  
  
  
  
  
  
  
  def fullname
    "#{firstname} #{surname}"
    
    #puts self.get_friend_path
  end
  
  
  def check_site(site)
    begin
      doc = Nokogiri::HTML.parse(open(site))
    rescue Exception => e
      self.errors.add(:long_website, 'Website invalid - must follow the form: example.com & be a real website')
      self.website = nil
      return false
    end
    return doc
  end
  
  def get_tags(doc)
    doc.css('h1, h2, h3').each do |tag|
      if(tag.inner_text.length < 256 && !tag.content.blank? && !tag.content.strip.empty?)
        Tag.create(:expert_id => self.id, :tag => tag.inner_text)
      end
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
