class UsersController < ApplicationController
  before_action :authenticate_user!

  def show
    @user = User.find params[:id]
    @search = @user.exams.joins(:category).search params[:q]
    @exams = @search.result.page params[:page]
  end
end
