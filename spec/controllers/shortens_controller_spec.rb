require 'spec_helper'

describe ShortensController do

  context "with mocks" do

    before :each do
      @shorten = Fabricate(:shorten)
    end

    describe "GET index" do
      it "assigns all Shortens to @shortens" do
        pending "Mongoid and Kaminari"

        Shorten.stub!(:desc).and_return [ @shorten ]
        get :index
        assigns(:shortens).should eq [ @shorten ]
      end
    end

    describe "GET show" do
      it "increments hit count" do
        Shorten.stub!(:where).and_return [ @shorten ]
        get :show
        @shorten.hit_count.should == 1
      end

      it "redirects to long_url" do
        Shorten.stub!(:where).and_return [ @shorten ]
        get :show
        response.should be_redirect
      end
    end

    describe "POST create" do

    end
  end
end
