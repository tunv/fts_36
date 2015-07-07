class Admin::UsersController < ApplicationController
  load_and_authorize_resource

  def index
    @users = @users.paginate page: params[:page]
  end

  def update
    @user.update_attributes role: :admin
    respond_to do |format|
      format.html
      format.js
    end
  end

  def destroy
    @user.destroy ? flash[:success] = t("delete_success") : flash[:danger] = t("delete_fail")
    redirect_to admin_users_path 
  end
end
