class StaticPagesController < ApplicationController

  def home
    if signed_in?
      @videopost  = current_user.videoposts.build
      @feed_items = current_user.feed.paginate(page: params[:page])
    end
  end

  def help
  end

  def about
  end
end