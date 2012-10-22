# controller methods
module Summit
  module Authorization
    # Deduce the name of the Devise resource from Devise mappings
    # This is not available until routes are loaded
    #
    # @return [String] the singular name of the deduced Devise resource
    def self.devise_resource_name
      Devise.mappings.first[1].path.singularize
    end

    # Setup authentication and authorization for ActiveAdmin
    # This is normally done in config/initializers/active_admin.rb
    # Current onfiguration is respected, if it exists. Otherwise it is added.

    # @param [String] singular name of the Devise resource (typically 'user' or 'admin_user')
    def self.initialize_active_admin_with_devise(resource_name)
      ActiveAdmin.setup do |config|
        config.authentication_method = devise_authentication_method(resource_name) unless config.authentication_method
        config.current_user_method = devise_current_user_method(resource_name) unless config.current_user_method
      end
    end

    protected

    def self.devise_authentication_method(resource_name)
      :"authenticate_#{resource_name}!"
    end

    def self.devise_current_user_method(resource_name)
      :"current_#{resource_name}"
    end

  end
end

require 'summit/authorization/controller_methods'
