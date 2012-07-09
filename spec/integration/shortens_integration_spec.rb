require 'spec_helper'

feature "Shortens" do

  scenario "are displayed on the home page" do
    shorten = Fabricate(:shorten)
    visit "/"
    page.should have_content shorten.short_url
    page.should have_content shorten.long_url
  end

  scenario "can be created from the home page" do
    visit "/"
    fill_in "shorten_long_url", with: "http://wellmadeworld.com/"
    click_button "Shorten"
    Shorten.count.should == 1
    Shorten.last.long_url == "http://wellmadeworld.com/"
    page.should have_content Shorten.last.short_url
  end

  describe "while logged in" do
    background do
      @someone_elses_shorten = Fabricate(:shorten, long_url: "http://wellmadeworld.com/")

      @user = Fabricate(:user)
      visit "/login"
      fill_in "user_email", with: @user.email
      fill_in "user_password", with: @user.password
      click_button "Sign in"
    end

    scenario "can create my shortens" do
      visit "/"
      fill_in "shorten_long_url", with: "http://foo.com/"
      click_button "Shorten"
      Shorten.count.should == 2  # someone_elses_shorten
      Shorten.last.long_url.should == "http://foo.com/"
      page.should have_content Shorten.last.short_url

      @user.shortens.count.should == 1
    end

    scenario "can create shortens from my shortens page" do
      visit "/users/#{@user.id}"
      fill_in "shorten_long_url", with: "http://foo.com/"
      click_button "Shorten"
      Shorten.count.should == 2  # someone_elses_shorten
      Shorten.last.long_url.should == "http://foo.com/"
      page.should have_content Shorten.last.short_url
    end

    scenario "can view my shortens" do
      visit "/users/#{@user.id}"
      fill_in "shorten_long_url", with: "http://foo.com/"
      click_button "Shorten"

      page.should have_content "http://foo.com/"
      page.should_not have_content @someone_elses_shorten.long_url
    end

    scenario "can delete my shortens" do
      pending "Delete method makes HTTP_REFERER unavailable to Capybara"
      # @see http://def-end.com/post/13161102203/how-to-test-links-with-delete-method-in

      visit "/users/#{@user.id}"
      fill_in "shorten_long_url", with: "http://foo.com/"
      click_button "Shorten"

      page.should have_content "http://foo.com/"

      #click_link "Delete"
      #request.env["HTTP_REFERER"] = user_path(@user)
      Capybara.current_session.driver.delete shorten_path(Shorten.last.id)
      Shorten.count.should == 1  # someone_elses_shorten
      Shorten.last.long_url.should_not == "http://foo.com/"
      page.should_not have_content "http://foo.com/"
    end
  end
end

