class ApplicationController < ActionController::Base
  # before_action :update_sanitized_params, if: :devise_controller?

    def update_sanitized_params
       devise_parameter_sanitizer.for(:sign_up) {|u| u.permit(:name, :gender, :email,   :password, :password_confirmation)}
    end
end
