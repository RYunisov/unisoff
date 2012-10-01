class Product < ActiveRecord::Base

  #require '/unicode/rustext.rb'  

  attr_accessible :content, :price, :status, :title, :phone, :category_id, :city_id, :email, :images_attributes

  has_many :images, :dependent => :destroy
  
  accepts_nested_attributes_for :images, :reject_if => :all_blank,
                                         :allow_destroy => true
  
  belongs_to :user
  belongs_to :city
  belongs_to :category

  email_regex = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i

  validates :email, :presence => true,
		  			:format => { :with => email_regex }

  validates_numericality_of :price, :only_integer => true

  before_save :caps_title
  def caps_title
    self.title = self.title.mb_chars.capitalize
  end

  before_validation :match_phones
  def match_phones
   self.phone = self.phone.gsub(/\D/, '').to_i
  end

  default_scope :order => 'products.created_at DESC'

  scope :from_users_followed_by, lambda { |user| followed_by(user) }

  def self.search(query)
	if query
	  find(:all, 
           :conditions => ['( title LIKE ? OR content LIKE ? )', "%#{query}%", "%#{query}%" ], 
           #:group => :title
           )
	else
	  find(:all)
	end
  end 

  def self.search_by_city(query, city)
    @text = ''  
	if query
        query.title.split.each do |q|
          @text += %( (title LIKE "%#{q}%" OR content LIKE "%#{q}%") AND ( id <> :id ) ) 
          @text += %( OR ) unless q == query.title.split.last
        end    
        if city.blank?
          where("#{@text}
                   AND ( category_id = :category_id )", 
                   { :query => "%#{query.title}%", 
                     :id => query.id, 
                     :category_id => query.category_id })
        else  
           where("#{@text}
                    AND ( category_id = :category_id ) 
                    AND ( city_id = :city_id)",
                    { :query => "%#{query.title}%", 
                      :id => query.id, 
                      :category_id => query.category_id,
                      :city_id => city.id })
        
	    end
    else
      all
	end
  end 

  def self.from_users_followed_by(user)
   if !user.following_ids.empty?
	 following_ids = user.following.map(&:id).join(", ")
   else
     following_ids = user.id 
   end	 
	 where("user_id IN (#{following_ids}) OR user_id  = ?", user)
#	where(:user_id => user.following.push(user))
  end
  
  def self.change_city(city_id)
    where(' city_id = ? ', city_id)
  end

  private
  
  def self.followed_by(user)
      following_ids = %(SELECT followed_id FROM relationships
							                        WHERE follower_id = :user_id)
#	  if following_ids.empty? 
#		 following_ids = user.id
#	  end 	 
      where("user_id IN (#{following_ids}) OR user_id = :user_id",
										            { :user_id => user })
  end
end
