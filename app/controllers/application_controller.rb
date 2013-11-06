class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  before_filter :pre_action

  def pre_action
    if user_signed_in?
      @user = current_user
    end
  end

  def login_required
    redirect_to login_path unless user_signed_in?
  end
end
