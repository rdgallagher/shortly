class ShortensController < ApplicationController

  def index
    #@shortens = Shorten.find(:all, order: "hit_count")
    @shortens = Shorten.find(:all)
    @shorten = Shorten.new
  end

  def show
    @shorten = Shorten.find_by_short_url(params[:short_url])
    @shorten.hit_count += 1
    @shorten.save!
    redirect_to @shorten.long_url, status: 301
  end

  def new
    @shorten = Shorten.new
  end

  def create
    # TODO: Create short URL. (@see SecureRandom) If exists, pick another
    @shorten = Shorten.new(params[:shortens])
    #@shorten.short_url = SecureRandom.urlsafe_base64(6)

    #begin
      @shorten.save!

    #rescue

    #end
  end

  def destroy
    # TODO: Correct user filter
  end
end
