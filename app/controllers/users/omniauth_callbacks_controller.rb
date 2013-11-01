class Users::OmniauthCallbacksController < Devise::OmniauthCallbacksController
  include Devise::Controllers::Rememberable

  def hatena
    @user = User.find_for_hatena_oauth(request.env["omniauth.auth"], current_user)
    remember_me(@user)

    if @user.persisted?
      flash[:notice] = I18n.t "devise.omniauth_callbacks.success", :kind => "Hatena"
      sign_in_and_redirect @user, :event => :authentication
    else
      session["devise.hatena_data"] = request.env["omniauth.auth"]
      redirect_to new_user_registration_url
    end    
  end
end
