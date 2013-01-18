require 'spec_helper'
require 'factory_girl_rails'

describe RolesUi::RolesController do
  let!(:admin){ FactoryGirl.create :admin }
  let!(:user){ FactoryGirl.create :user }
  let!(:role){ FactoryGirl.create :role }

  def role_parameters
    @valid_parameters = { :name => 'another_role' ,
      :permissions_attributes => { 
        '0' => { :name => 'read_all' },
        '1' => { :name => 'manage' } }
    }
    @blank_name_parameters = { 
      :name => '' 
    }
  end

  before do
    stub_current_user(admin)
  end

  describe "GET 'index'" do
    before { get :index }

    it_should_behave_like 'displays'

    it 'should render roles/index template' do
      response.should render_template('roles_ui/roles/index')
    end

    it 'should contain all roles' do
      assigns[:roles].count.should == RolesUi::Role.count
    end
  end

  describe "GET 'new'" do
    before { get :new }

    it_should_behave_like 'displays'

    it 'should render roles/new template' do
      response.should render_template('roles_ui/roles/new')
    end
  end

  describe "GET 'edit'" do
    before { get :edit, :id => role.id }

    it_should_behave_like 'displays'

    it 'should render roles/edit template' do
      response.should render_template('roles_ui/roles/edit')
    end
  end

  describe 'POST create' do
    before { role_parameters }

    describe 'with valid parameters' do
      before { post :create, :roles_ui_role => @valid_parameters }

      it 'should create new role' do
        RolesUi::Role.all.should include(assigns(:role))
      end

      it 'should has 1 permission' do
        assigns(:role).permissions.count == 1
      end
      
      it 'should redirect to role show' do
        response.should redirect_to("/roles/#{User.last.id}")
      end
    end

    describe 'with blank name' do
      before { post :create, :roles_ui_role => @blank_name_parameters }

      it 'should not create new role' do
        RolesUi::Role.all.should_not include(assigns(:role))
      end

      it 'should render roles/new template' do
        response.should render_template('roles_ui/roles/new')
      end
    end
  end
  
  describe "POST update" do
    before { role_parameters }
  
    describe 'with valid parameters' do
      before { post :update, :id => RolesUi::Role.last.id, :roles_ui_role => @valid_parameters }
  
      it 'should redirect to role show' do
        response.should redirect_to("/roles/#{RolesUi::Role.last.id}")
      end
    end
  
    describe 'with blank name' do
      before { post :update, :id => RolesUi::Role.last.id, :roles_ui_role => @blank_name_parameters }
  
      it 'should render roles/edit template' do
        response.should render_template('/roles/edit')
      end
    end
  end
  
  describe  "DELETE destroy" do
    before { delete :destroy, :id => role.id }
  
    it 'should be deleted' do
      RolesUi::Role.all.should_not include(role)
    end
  end
end