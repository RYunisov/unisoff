class PagesController < ApplicationController
	
  before_filter :city

  def home
    @title = "Home"
	@category = Category.all
	@city = City.all
  end

  def contact
    @title = 'Contact'
  end

  def about
    @title = 'About'
  end

  def help
    @title = 'Help'
  end

  def city
   unless current_city.nil?
	 @product = Product.where('city_id = ?', current_city.id)
	else
	 @product = Product.all 
	end
  end
end
