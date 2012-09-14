# encoding: utf-8
class CategoriesController < ApplicationController
  def show
    @cat = Category.find(params[:id])
	@product = @cat.product
	@category = Category.all
    render 'pages/home' 
  end
  def create
	@category = Category.create(params[:category])
	if @category.save
		flash[:success] = "Категория #{@category.param_name} создана"
		redirect_to roots_category_path
	else
		flash[:error] = 'Что-то пошло не так'
	end		
  end
end
