class Shorten
  include Mongoid::Document
  include Mongoid::Timestamps

  field :short_url, :type => String
  field :long_url, :type => String
  field :user_id, :type => Integer
  field :hit_count, :type => Integer, :default => 0

  validates_presence_of :long_url
  validates_format_of :long_url, :with => URI::regexp(%w(http https))
  validates_presence_of :short_url
  validates_uniqueness_of :short_url

  index({ long_url: 1 }, { background: true })
  index({ short_url: 1 }, { background: true, unique: true })
  index({ user_id: 1 }, { background: true })
end
