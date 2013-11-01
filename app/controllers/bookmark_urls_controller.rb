class BookmarkUrlsController < ApplicationController

  def create
    @form = BookmarkUrlForm.new(params[:bookmark_url_form])
    if @form.valid?
      redirect_to root_path
    else
      render 'pages/home'
    end
  end
  
end
