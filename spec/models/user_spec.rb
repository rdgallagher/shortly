require 'spec_helper'

describe User do
  let :user do
    Fabricate(:user)
  end

  context 'validations' do
    it { should validate_presence_of :email }

    it 'should validate uniqueness of email' do
      pending 'set password and confirm password'

#      user.save!
#      User.new({ email: Faker::Internet.email }).should_not be_valid
    end
  end

  context 'associations' do
    pending 'matcher not available in mongoid'

#    it { should have_many :shortens }
  end
end
