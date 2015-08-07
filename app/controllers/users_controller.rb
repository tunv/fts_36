class UsersController < ApplicationController
  before_action :authenticate_user!

  def show
    @user = User.find params[:id]
    @search = @user.exams.joins(:category).search params[:q]
    @exams = @search.result.page params[:page]
  end

  def edit
    # authorize! :update, @user
  end

  def finish_signup
    @user = User.find params[:id]
    if request.patch?
        @user.update_attributes(email: params[:user][:email])
        sign_in(@user, :bypass => true)
        redirect_to @user, notice: 'Your profile was successfully updated.'
    end
  end
end
