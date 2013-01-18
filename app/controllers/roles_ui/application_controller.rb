module RolesUi
  class ApplicationController < ActionController::Base
    before_filter :roles_ui_authenticate

    layout RolesUi.engine_layout

    cattr_accessor :user_classes
    @@user_classes = RolesUi.user_classes

    def access_denied
      flash[:alert] = I18n.t('access_denied',
        :default => 'You do not have sufficient permissions to access this page.')
      render :access_denied
  	end

    protected

    def roles_ui_authenticate
      access_denied unless instance_eval(&RolesUi.authenticate_with)
    end
  end
end