class PagesController < ApplicationController
  def home
    unless user_signed_in?
      redirect_to login_path
    end

    @form = BookmarkUrlForm.new
  end

  def login
    if user_signed_in?
      redirect_to root_path
    end
  end
end
