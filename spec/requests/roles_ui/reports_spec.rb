require 'spec_helper'
require 'factory_girl_rails'
require_relative 'helpers/intregration_helper'

describe 'check access' do
  let!(:admin){ FactoryGirl.create :admin }
  let!(:user){ FactoryGirl.create :user }

  def table_selector
    'table.table-striped.table-bordered'
  end
  
  describe 'visiting report' do
    context 'as an admin' do
      before do 
        login admin
        visit '/permissions_report'
      end
        
      it 'access should be granted' do
        page.should_not have_content('You do not have sufficient permissions to access this page')
      end
      
      it 'should have table selector' do
        page.should have_selector table_selector
      end
    end
  end
end