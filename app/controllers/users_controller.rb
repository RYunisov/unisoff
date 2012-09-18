# encoding: utf-8
class UsersController < ApplicationController
  before_filter :authenticate, :except => [:show, :new, :create] 
  before_filter :correct_user, :only => [:edit, :update]
  before_filter :admin_user, :only => [:destroy]
  before_filter :check_signed, :only => [:create, :new]

  def following
    @title = "Following"
    @user = User.find(params[:id])
    @users = @user.following.paginate(:page => params[:page])
    render 'show_follow'
  end

  def followers
    @title = "Followers"
    @user = User.find(params[:id])
    @users = @user.followers.paginate(:page => params[:page])
    render 'show_follow'
  end

  def destroy
    User.find(params[:id]).destroy
    flash[:success] = "Пользователь удален"
    redirect_to users_path
  end

  def create
    @user = User.new(params[:user])
	if @user.save
	 sign_in @user
	 flash[:success] = "Добро пожаловать!"
     redirect_to @user
	else
	 @title = "Sign up"
	 render 'new'
	end
  end

  def index
    @title = "Пользователи"
	@users = User.paginate(:page => params[:page])
  end

  def show
	@user = User.find(params[:id])
	@title = @user.login
	@product = @user.products 
	if signed_in? #&& !current_user.feed.nil?
      @feed_items = @user.feed.paginate(:page => params[:page])
    end
  end

  def new
    @user = User.new
    @title = "Создание нового пользователя"
  end

  def edit
	@title = "Редактирование пользователя"
  end

  def update
	if @user.update_attributes(params[:user])
	  flash[:success] = "Профиль обновлен"
	  redirect_to @user
	else
	  @title = "Редактирование пользователя"
	  render 'edit'
	end
  end
  
private

  def authenticate
    deny_access unless signed_in?
  end

  def correct_user
    @user = User.find(params[:id])
	redirect_to(root_path) unless current_user?(@user)
  end
  
  def admin_user
	@user = User.find(params[:id])
    if @user.admin? 
     redirect_to users_path, :notice => "Вы не можете удалить админа" 
     redirect_to(root_path) unless current_user.admin?
	end  
  end
 
  def check_signed
    if signed_in?
      redirect_to root_path, :notice => "Не зачем повторятся, Вы уже зарегистированы"
    end
  end

end
