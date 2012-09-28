class UsersController < ApplicationController
  before_filter :signed_in_user, only: [:index, :edit, :update, :destroy]
  before_filter :correct_user,   only: [:edit, :update]
  before_filter :admin_user,     only: :destroy

  respond_to :html, :xml

  def show
    @user = User.find(params[:id])
    @videoposts = @user.videoposts.paginate(page: params[:page])
    respond_with @user
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(params[:user])
    if @user.save
      respond_with @user
      sign_in @user
      flash[:success] = "Welcome to MyTube!"
      #redirect_to @user
    else
      render 'new'
    end
  end

  def edit
  end

  def update
    if @user.update_attributes(params[:user])
      respond_with @user
      flash[:success] = "Profile updated"
      sign_in @user
      #redirect_to @user
    else
      render 'edit'
    end
  end

  def index
    @users = User.paginate(page: params[:page])
    respond_with @users
  end

  def destroy
    User.find(params[:id]).destroy
    flash[:success] = "User destroyed."
    #redirect_to users_url
    respond_with @user
  end

  private

  def signed_in_user
    unless signed_in?
      store_location
      redirect_to signin_url, notice: "Please sign in."
    end
  end

  def correct_user
    @user = User.find(params[:id])
    redirect_to(root_path) unless current_user?(@user)
  end

  def admin_user
    redirect_to(root_path) unless current_user.admin?
  end
end