class PagesController < ApplicationController
  def home
    unless user_signed_in?
      redirect_to :login
    end
  end

  def login
    if user_signed_in?
      redirecto_to :home
    end
  end
end
