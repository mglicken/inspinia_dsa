class RegistrationsController < Devise::RegistrationsController
   #skip_before_filter is deprecated in rails 5.1
  skip_before_filter :require_no_authentication, only: [:new]

  private

  def new
  	super
  end
  
  def sign_up_params
    params.require(:user).permit( :email, :password, :password_confirmation, :access_id, :person_id)
  end

  def account_update_params
    params.require(:user).permit( :email, :password, :password_confirmation, :current_password, :access_id, :person_id)
  end

end 