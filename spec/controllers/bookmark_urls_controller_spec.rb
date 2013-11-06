require 'spec_helper'

describe BookmarkUrlsController do
  include Devise::TestHelpers

  before do
    @user = create_user
    response = Object.new()
    response.instance_eval { class << self; attr_accessor :code; end; }

    access_token = Object.new()
    access_token.stub(:post).and_return(response)

    OAuth::AccessToken.stub(:new).and_return(access_token)
  end

  
  describe "POST 'create'" do
    context "for signed in user" do
      before do
        @user = create_user
        sign_in @user
      end
      
      it "redirects to root path" do
        post 'create', bookmark_url_form:{url:'http://google.com'}
        expect(response).to redirect_to root_path
      end

      it "renders the pages/home template" do
        post 'create', bookmark_url_form:{url:''}
        expect(response).to render_template("pages/home")
      end
    end

    context "for not signed in user" do
      it "redirects to root path" do
        post 'create', bookmark_url_form:{url:'http://google.com'}
        expect(response).to redirect_to login_path
      end
    end
    
  end

end
