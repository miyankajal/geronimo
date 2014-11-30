class ApplicationController < ActionController::Base
      # Prevent CSRF attacks by raising an exception.
      # For APIs, you may want to use :null_session instead.
      helper :all
      protect_from_forgery with: :null_session
      before_action :current_user
      before_filter :prepare_for_mobile
      
      before_filter do
          resource = controller_path.singularize.gsub('/', '_').to_sym
          method = "#{resource}_params"
          params[resource] &&= send(method) if respond_to?(method, true)
        end
      
      include SessionsHelper
      

      rescue_from CanCan::AccessDenied do |exception|
        redirect_to root_url, :alert => exception.message
      end

    private
    def mobile_device?
        request.user_agent =~ /Mobile|webOS|iPhone/ && !(request.user_agent =~ /iPad/)
    end
    helper_method :mobile_device?

    def prepare_for_mobile
        prepend_view_path "#{Rails.root}/app/views/mobile" if mobile_device?
    end
end
