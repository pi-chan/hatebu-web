class BookmarkUrlsController < ApplicationController

  before_filter :login_required

  def create
    @form = BookmarkUrlForm.new(params[:bookmark_url_form])
    if @form.valid?
      if @user.bookmark(@form.url)
        redirect_to root_path, notice: "new bookmark is successfully created."
      else
        redirect_to root_path, notice: "cannot create a new bookmark."
      end
    else
      render 'pages/home'
    end
  end
  
end
