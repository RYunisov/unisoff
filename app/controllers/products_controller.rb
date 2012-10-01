# encoding: utf-8
class ProductsController < ApplicationController

 before_filter :correct_user, :only => [:edit, :update]
 before_filter :f_city, :except => [:update, :create, :show, :all_products, :search]
 before_filter :category
 before_filter :signed_user, :only => [:destroy, :edit, :update] 

  def search 
    @product = Product.search(params[:query])
    respond_to do |format|
      format.html { render :layout => false }
      format.json { render :json => @product.map(&:attributes) }
    end  
  end

  def index
    if params[:query] and !current_city.nil? 
      @product = Product.search_by_city(params[:query], current_city.id)
    else
      @product = Product.search(params[:query])
    end  
	render 'pages/home'
  end

  def new
    @product = Product.new
    3.times { @product.images.build }
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
    current_city = '' if current_city.nil?
    @altproduct = Product.search_by_city(@product, current_city)
  end
  
  def edit
    @product = Product.find(params[:id])
    3.times { @product.images.build }
  end
  
  def update
   @product = Product.find(params[:id])
   if @product.update_attributes(params[:product])
     flash[:success] = "Объявление #{@product.title} отредактировано"
     redirect_to @product
   else
     render 'edit'
     flash[:error] = 'Произошла ошибка'
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
    unless signed_in?
      redirect_to product_path, :notice => 'Не хватает прав, для редактирования' 
    end
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
    @user = Product.find(params[:id]).user
    redirect_to product_path, :notice => 'Не хватает прав, для редактирования' unless current_user.to_s.empty? or @user == current_user or current_user.admin
  end

end
