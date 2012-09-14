# encoding: utf-8
class ProductsController < ApplicationController

 before_filter :correct_user, :only => [:edit, :update]
 before_filter :f_city, :except => [:update, :create, :show, :all_products ]
 before_filter :category
 before_filter :signed_user, :only => [:destroy] 

  def index
    if params[:query] and !current_city.nil? 
      @product = Product.search_by_city(params[:query], current_city.id)
    else
      @product = Product.search(params[:query])
    end  
	@category = Category.all
	render 'pages/home'
  end

  def new
    @product = Product.new
  end
  
  def create
  if signed_in? 
    @product = current_user.products.new(params[:product])
  else
    @product = Product.new(params[:product])
	@product[:user_id] = 0
  end
	if @product.save
		flash[:success] = "Объявление #{@product.title} добавлено"
		@title = @product.title
		redirect_to @product
	else
		flash[:error] = "Давайте заполнять поля правильно(="
		render :new
	end
  end
  
  def show
    @product = Product.find(params[:id])
	  @title = @product.title
	  @category = Category.all
  end
  
  def edit
    if signed_in?
      @product = Product.find(params[:id])
	else
      redirect_to product_path, :notice => 'Не достаточно прав для редактирования'
	end
    @category = Category.all
  end
  
  def update
   if @product.update_attributes(params[:product])
	   flash[:success] = "Объявление #{@product.title} отредактировано"
	   redirect_to @product
   else
     render 'edit'
   end
  end
  
  def destroy
	  Product.find(params[:id]).destroy
	  redirect_to root_path
  end

  def all
    @title = "Все сообщения от пользователя"
    @product = Product.find(:all, :conditions => { :email => Product.find(params[:id]).email })
	render 'pages/home'
  end

private

  def signed_user
    redirect_to :back unless signed_in?
  end

  def category 
    @category = Category.all
  end 

  def f_city
  	unless params[:value].nil? 
 	 unless params[:value].empty? 
  	 cookies[:city_id] = params[:value]
  	 @product = Product.where('city_id = ?', current_city.id)
	   render :text => "<i>#{current_city.param_name}</i>"
	 else
	   cookies[:city_id] = nil
	   @product = Product.all
	   render :text => "<i>Все города</i>"
	 end
  	else
  	  @product = Product.all
  	end  
  end

  def correct_user
   @product = Product.find(params[:id])
   redirect_to product_path unless current_user.to_s.empty? or @product.user_id == current_user[:id] or current_user.admin
  end

end
