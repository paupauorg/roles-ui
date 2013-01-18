require 'spec_helper'
require 'factory_girl_rails'
require_relative 'helpers/intregration_helper'

describe 'check access' do
  let!(:admin){ FactoryGirl.create :admin }
  let!(:user){ FactoryGirl.create :user }

  describe 'visiting root' do
    context 'as a guest' do
      it 'access should be denied' do
        visit '/roles_ui'
        page.should have_content('You do not have sufficient permissions to access this page')
      end
    end

    context 'as an user' do
      it 'access should be denied' do
        login user
        visit '/roles_ui'
        page.should have_content('You do not have sufficient permissions to access this page')
      end
    end

    context 'as an admin' do
      it 'access should be granted' do
        login admin
        visit '/roles_ui'
        page.should_not have_content('You do not have sufficient permissions to access this page')
      end
    end
  end
end
