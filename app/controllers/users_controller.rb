class UsersController < ApplicationController

  before_filter :authenticate_user!
  before_filter :correct_user

  def show
    @user = User.find(params[:id])
    @shortens = @user.shortens.page(params[:page])
    @shorten = Shorten.new
  end

  private

    def correct_user
      @user = User.find(params[:id])
      redirect_to(root_path) unless current_user == @user
    end
end