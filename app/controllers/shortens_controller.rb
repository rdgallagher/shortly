class ShortensController < ApplicationController
  include ShortensHelper

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
    @shorten.long_url = 'http://' + @shorten.long_url unless @shorten.long_url.start_with?('http://', 'https://')

    # Assign SecureRandom short_url - if exists, pick another
    while !@shorten.valid?
      @shorten.short_url = SecureRandom.urlsafe_base64(4)
    end

    current_user.shortens << @shorten if signed_in?

    respond_to do |format|
      if @shorten.save(validate: false)
        flash[:success] = "Here is your short URL: #{full_url(@shorten.short_url)}"
        format.html { redirect_to root_path }
        format.js { render js: @shorten, status: :created, location: @shorten }
      else
        format.html { render :new }
        format.js { render js: @shorten.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    # TODO: Correct user filter
  end
end
