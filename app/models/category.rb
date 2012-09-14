class Category < ActiveRecord::Base

  has_many :product 
  
  attr_accessible :param_name, :product_id

end
