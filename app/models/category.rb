class Category < ActiveRecord::Base

  attr_accessible :param_name, :product_id, :category_id
  has_many :product 
 
  belongs_to :parent, :class_name => 'Category', :foreign_key => 'category_id'
  has_many :child, :class_name => 'Category', :foreign_key => 'category_id'

end
