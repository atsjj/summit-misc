module Summit
  module Authorization
    module ControllerMethods

      protected

      # cancan
      if defined? CanCan
        rescue_from CanCan::AccessDenied do |exception|
          render_401 exception.message
        end

        def current_ability
          @current_ability ||= Ability.new(current_customer)
        end

        def authenticate_admin_user!
          authorize! :manage, :all
        end
      end

      # general
      def render_static_401(message='You are not authorized to access that page.')
        @message = message

        respond_to do |format|
          format.html { render :file => "#{Rails.root}/public/401", :formats => [:html], :status => 401, :layout => false }
          format.xml  { head 401 }
          format.any  { head 401 }
        end
      end
    end
  end
end
