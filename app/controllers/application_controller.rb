class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :configure_permitted_parameters, if: :devise_controller?
  before_action :store_user_location!, if: :storable_location?
  before_action :authenticate_user!

  def authorize_admin!
    unless current_user.admin?
      render_not_authorized_error
    end
  end

  def render_not_authorized_error
    respond_to do |format|
      format.html {
        render file: "#{Rails.root}/public/422",
        layout: false,
        status: 422
      }
    end
  end

  private

    def storable_location?
      request.get? && is_navigational_format? && !devise_controller? && !request.xhr?
    end

    def store_user_location!
      # :user is the scope we are authenticating
      store_location_for(:user, request.fullpath)
    end

    def after_sign_in_path_for(resource)
      if resource.admin?
        stored_location_for(resource) || dashboards_path
      else
        stored_location_for(resource) || user_path(resource)
      end
    end

  protected

    def configure_permitted_parameters
      devise_parameter_sanitizer.permit(:sign_up, keys: [:name])
      devise_parameter_sanitizer.permit(:account_update, keys: [:name])
    end

end
