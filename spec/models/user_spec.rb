require 'spec_helper'

describe User do
  let :user do
    Fabricate(:user)
  end

  context 'validations' do
    it { should validate_presence_of :email }
    it { should validate_uniqueness_of :email }
  end

  context 'associations' do
    it { should have_many :shortens }
  end
end
