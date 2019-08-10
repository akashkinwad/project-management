class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :configure_permitted_parameters, if: :devise_controller?

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

    def after_sign_in_path_for(resource)
      if resource.admin?
        dashboards_path
      else
        user_path(resource)
      end
    end

  protected

    def configure_permitted_parameters
      devise_parameter_sanitizer.permit(:sign_up, keys: [:name])
      devise_parameter_sanitizer.permit(:account_update, keys: [:name])
    end

end
