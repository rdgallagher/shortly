class ShortensController < ApplicationController
  include ShortensHelper

  before_filter :check_owner, only: [:destroy]

  def index
    @shortens = Shorten.desc(:hit_count).page(params[:page])

    @shorten = Shorten.new
  end

  def show
    @shorten = Shorten.where(short_url: params[:short_url]).first
    @shorten.hit_count = @shorten.hit_count + 1
    @shorten.save!
    redirect_to @shorten.long_url, status: 301
  end

  def new
    @shorten = Shorten.new
  end

  def create
    @shorten = Shorten.new(params[:shorten])

    # Add protocol if missing
    @shorten.long_url = 'http://' + @shorten.long_url unless @shorten.long_url.blank? or @shorten.long_url.start_with?('http://', 'https://')

    # Assign SecureRandom short_url - if exists, pick another
    begin
      @shorten.short_url = SecureRandom.urlsafe_base64(4)
    end while Shorten.where(short_url: @shorten.short_url).exists?

    current_user.shortens << @shorten if signed_in?

    if @shorten.save
      flash[:success] = "Here is your short URL: <a href='#{full_url(@shorten.short_url)}' target='_blank'>#{full_url(@shorten.short_url)}</a>".html_safe
      redirect_to :back
    else
      flash[:error] = "That URL was invalid."
      redirect_to :back
    end
  end

  def destroy
    @shorten = Shorten.find(params[:id])
    long_url = @shorten.long_url
    @shorten.destroy
    flash[:success] = "Your Shorten to #{long_url} has been deleted."
    redirect_to :back
  end

  private

    def check_owner
      redirect_to(root_path) unless signed_in? and current_user.shortens.find(params[:id]).present?
    end
end
