class RegistrationsController < Devise::RegistrationsController

  private

  def sign_up_params
    params.require(:user).permit( :email, :password, :password_confirmation, :access_id, :person_id)
  end

  def account_update_params
    params.require(:user).permit( :email, :password, :password_confirmation, :current_password, :access_id, :person_id)
  end

end 