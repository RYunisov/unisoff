class City < ActiveRecord::Base
  attr_accessible :param_name

  has_many :products
end
