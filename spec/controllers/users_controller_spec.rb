require 'spec_helper'

describe UsersController do

  context "with mocks" do

    def mock_user(stubs = {})
      @mock_user ||= mock_model(User, stubs).as_null_object
    end

    def mock_shorten(stubs = {})
      @mock_shorten ||= mock_model(Shorten, stubs).as_null_object
    end

    before :each do
      controller.stub(:authenticate_user!).and_return nil
      controller.stub(:correct_user).and_return nil
      controller.stub(:current_user).and_return { @mock_user }
    end

    describe "GET show" do

      it "assigns user's shortens to @shortens" do
        User.stub!(:find).and_return mock_user
        mock_user.stub!(:shortens).and_return [ mock_shorten ]
        get :show
        assigns(:shortens).should eq [ mock_shorten ]
      end
    end
  end
end
