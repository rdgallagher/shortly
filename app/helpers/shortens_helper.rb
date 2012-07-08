module ShortensHelper

  def full_url(short_url)
    request.protocol + request.host + (request.port.nil? ? '' : ":#{request.port}") + '/' + short_url
  end
end
