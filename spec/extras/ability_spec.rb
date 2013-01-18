require 'spec_helper'
require 'cancan/matchers'
require 'factory_girl_rails'

describe 'abilty check' do
  let!(:admin){ FactoryGirl.create :admin }
  let!(:user){ FactoryGirl.create :user }


  shared_examples 'non-admin user' do
    it 'should not be able to do everything' do
      should_not be_able_to(:manage, :all)
    end
  end

  describe 'admin' do
    subject { Ability.new(admin) }

    it 'should be able to do everything' do
      should be_able_to(:manage, :all)
    end
  end
end