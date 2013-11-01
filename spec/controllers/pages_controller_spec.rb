require "spec_helper"

describe PagesController do
  include Devise::TestHelpers

  before do
    @user = create_user
  end

  context "actions for not signed in user" do
    context "GET 'home'" do
      it "redirect to login path" do
        get 'home'
        expect(response).to redirect_to login_path
      end
    end

    context "GET 'login'" do
      it "renders the login template" do
        get 'login'
        expect(response).to render_template("login")
      end
    end
    
  end

  context "actions for signed in user" do
    before { sign_in @user }

    context "GET 'home'" do
      it "renders the home tamplate" do
        get 'home'
        expect(response).to render_template("home")
      end
    end

    context "GET 'login'" do
      it "redirect to home" do
        get 'login'
        expect(response).to redirect_to root_path
      end
    end
  end
end
