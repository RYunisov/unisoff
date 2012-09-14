# encoding: utf-8
class RootsController < ApplicationController
  
  before_filter :admin

  def index
	redirect_to :action => :cities
  end
  def cities
	@title = 'Города'
	@city = City.all
  end
  def users
	@title = 'Пользователи'
	@user = User.all
  end
  def category
	@title = 'Категории'
    @category = Category.all
  end
  def show
	@city = City.all	
	@user = User.all
  end

private
  
  def admin
	redirect_to root_path if current_user.nil?
	unless current_user.nil?
		redirect_to root_path unless current_user.admin
	end
  end	
end
