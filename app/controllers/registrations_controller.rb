class RegistrationsController < Devise::RegistrationsController

  def update_resource(resource, params)
    resource.update_without_password(params)
  end

  # DELETE /resource
  def destroy
    user = current_user
    user.games.destroy_all
    resource.destroy
    Devise.sign_out_all_scopes ? sign_out : sign_out(resource_name)
    set_flash_message :notice, :destroyed if is_flashing_format?
    yield resource if block_given?
    respond_with_navigational(resource){ redirect_to after_sign_out_path_for(resource_name) }
  end

end
