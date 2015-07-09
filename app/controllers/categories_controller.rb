class CategoriesController < ApplicationController
  load_and_authorize_resource

  def index
    @categories = @categories.paginate page: params[:page]
  end
end
