class Shorten
  include Mongoid::Document
  include Mongoid::Timestamps

  field :short_url, :type => String
  field :long_url, :type => String
  field :user_id, :type => Integer

  validates_presence_of :long_url
  validates_presence_of :short_url
  validates_uniqueness_of :short_url

  index({ long_url: 1 }, { background: true })
  index({ short_url: 1 }, { background: true, unique: true })
  index({ user_id: 1 }, { background: true })
end
