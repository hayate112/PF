class ApplicationController < ActionController::Base
  before_action :configure_permitted_parameters, if: :devise_controller?

  def after_sign_in_path_for(resource)
    root_path
  end

  def after_sign_out_path_for(resource)
    case params[:logout]
    when "0"
      root_path
    when "1"
      new_admin_session_path
    end
  end


  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:family_name, :name, :family_name_kana, :name_kana, :nickname, :phone_number, :postal_code, :prefectures, :city])
  end
end
