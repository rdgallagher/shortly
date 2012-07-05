require 'spec_helper'

describe Shorten do
  let :shorten do
    Fabricate(:shorten)
  end

  context 'validations' do
    it { should validate_presence_of :long_url }
    it { should validate_presence_of :short_url }

    it 'should validate uniqueness of short_url' do
      shorten.save!

      Shorten.new({ long_url: Faker::Internet.http_url, short_url: shorten.short_url }).should_not be_valid
    end
  end
end
