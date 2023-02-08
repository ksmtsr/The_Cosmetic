class ApplicationController < ActionController::Base
  before_action :configure_permitted_parameters, if: :devise_controller?

  def after_sign_in_path_for(resource)

    if customer_signed_in?
        customers_path
    elsif admin_signed_in?
        admin_root_path
    else
        new_admin_session_path
    end

  end


  def after_sign_out_path_for(resources)

    if resources == :customer
        root_path
    elsif resources == :admin
        new_admin_session_path
    else
        admin_root_path

    end

  end



  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:last_name, :first_name,
    :first_name_kana, :last_name_kana, :email, :address, :postal_code, :telephone_number])

    devise_parameter_sanitizer.permit(:sign_in, keys: [:email])

  end

end
