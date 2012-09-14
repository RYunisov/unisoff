# encoding: utf-8
class CitiesController < ApplicationController
 def index
   @city = City.all		 
 end
 def create
	@city = City.new(params[:city])
	if @city.save
	  flash[:success] = 'Вы создали новый город'
      redirect_to roots_cities_path	
	else
	  flash[:error] = 'Видимо что то пошло не так'
	end  
  end

  def destroy
	City.find(params[:id]).destroy
	redirect_to roots_cities_path
  end
end
