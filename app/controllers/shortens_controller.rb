class ShortensController < ApplicationController

  def index
    @shortens = Shorten.desc(:hit_count)

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
      @shorten.short_url = SecureRandom.urlsafe_base64(6)
    end

    current_user.shortens << @shorten if signed_in?

    if @shorten.save(validate: false)
      flash[:success] = "Here is your short URL: #{request.protocol + request.domain + (request.port.nil? ? '' : ":#{request.port}") + '/' + @shorten.short_url}"
      redirect_to root_path
    else
      render :new
    end
  end

  def destroy
    # TODO: Correct user filter
  end
end
