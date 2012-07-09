require 'spec_helper'

describe ShortensController do

  context "with mocks" do

    before :each do
      request.env['HTTP_REFERER'] = "http://foo.com/"
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

      it "redirects to long URL" do
        Shorten.stub!(:where).and_return [ @shorten ]
        get :show
        response.should redirect_to @shorten.long_url
      end
    end

    describe "POST create" do
      describe "with valid params" do

        it "saves a new Shorten" do
          expect {
            post :create, shorten: { 'long_url' => @shorten.long_url }
          }.to change{Shorten.count}.by(1)
        end

        it "adds protocol to long URL if necessary" do
          post :create, shorten: { 'long_url' => 'wellmadeworld.com' }
          Shorten.last.long_url.should == 'http://wellmadeworld.com'
        end

        it "redirects back" do
          post :create, shorten: { 'long_url' => @shorten.long_url }
          response.should redirect_to :back
        end
      end

      describe "with invalid params" do

        it "displays an error message" do
          post :create, shorten: { 'long_url' => '' }
          flash[:error].should_not be_nil
        end

        it "redirects back" do
          post :create, shorten: { 'long_url' => '' }
          response.should redirect_to :back
        end
      end
    end
  end
end
