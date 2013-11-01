require 'spec_helper'

describe BookmarkUrlsController do
  include Devise::TestHelpers

  describe "POST 'create'" do
    it "redirects to root path" do
      post 'create', bookmark_url_form:{url:'http://google.com'}
      expect(response).to redirect_to root_path
    end

    it "renders the pages/home template" do
      post 'create', bookmark_url_form:{url:''}
      expect(response).to render_template("pages/home")
    end
  end

end
