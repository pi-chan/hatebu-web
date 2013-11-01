require 'spec_helper'

describe BookmarkUrlForm do
  before do
    @form = BookmarkUrlForm.new
  end

  specify "model attributes" do
    expect(@form).to respond_to(:url)
  end

  context "validations" do
    specify "nil url" do
      expect(@form).not_to be_valid
    end

    specify "empty url" do
      @form.url = ''
      expect(@form).not_to be_valid
    end
    
    specify "invalid url" do
      @form.url = "alsdjfasldjfa"
      expect(@form).not_to be_valid
    end
    

    specify "valid url" do
      @form.url = "http://google.com"
      expect(@form).to be_valid
    end
    
    
  end
end
