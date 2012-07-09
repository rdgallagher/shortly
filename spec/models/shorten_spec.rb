require 'spec_helper'

describe Shorten do
  let :shorten do
    Fabricate(:shorten)
  end

  context 'validations' do
    it { should validate_presence_of :long_url }

    it { should validate_presence_of :short_url }
    it { should validate_uniqueness_of :short_url }
  end

  context 'associations' do
    it { should belong_to :user }
  end
end
