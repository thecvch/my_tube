class VideopostsController < ApplicationController
  before_filter :signed_in_user, only: [:create, :destroy]
  before_filter :correct_user,   only: :destroy

  respond_to :html, :xml, :js

  def create
    @videopost = current_user.videoposts.build(params[:videopost])
    if @videopost.save
      flash[:success] = "Video posted!"
      #redirect_to root_url
      respond_with(@videopost, location: root_url)
    else
      @feed_items = []
      render 'static_pages/home'
    end
  end

  def destroy
    @videopost.destroy
    #redirect_to root_url
    respond_with(@videopost, location: root_url)
  end

  private

  def correct_user
    @videopost = current_user.videoposts.find_by_id(params[:id])
    redirect_to root_url if @videopost.nil?
  end
end