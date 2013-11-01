require "spec_helper"

describe PagesController do
  include Devise::TestHelpers

  before do
    @user = create_user
  end

  describe "actions for not signed in user" do
    context "GET 'home'" do
      it "redirect to login path" do
        get 'home'
        response.should redirect_to login_path
      end
    end

    context "GET 'login'" do
      it "return http success" do
        get 'login'
        response.should be_success
      end
    end
    
  end

  describe "actions for signed in user" do
    before { sign_in @user }

    context "GET 'home'" do
      it "return http success" do
        get 'home'
        response.should be_success
      end
    end

    context "GET 'login'" do
      it "redirect to home" do
        get 'login'
        response.should redirect_to root_path
      end
    end
  end
end
