module RolesUi
  class RolesController < RolesUi::ApplicationController

    def index
      @roles = RolesUi::Role.all
    end

    def show
      @role = Role.find(params[:id])
    end

    def new
      @role = Role.new
      build_nested_models
    end

    def create
      @role = Role.new(params[:roles_ui_role])
      if @role.save
        redirect_to ({ controller: 'roles', action: 'show', id: @role.id }), :notice => "Successfully created role."
      else
        build_nested_models
        render :action => 'new'
      end
    end

    def edit
      @role = Role.find(params[:id])
      build_nested_models
    end

    def update
      @role = Role.find(params[:id])
      if @role.update_attributes(params[:roles_ui_role])
        redirect_to ({ controller: 'roles', action: 'show', id: @role.id }), :notice  => "Successfully updated role."
      else
        build_nested_models
        render :action => 'edit'
      end
    end

    def destroy
      @role = Role.find(params[:id])
      @role.destroy
      redirect_to ({ controller: 'roles', action: 'index' }), :notice => "Successfully destroyed role."
    end

    private

    def build_nested_models
      @role.permissions.build if @role.permissions.empty?
    end
  end
end