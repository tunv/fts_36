class CategoriesController < ApplicationController
  load_and_authorize_resource

  def index
    @search = Category.search params[:q]
    @categories = @search.result.page params[:page]

    respond_to do |format|
      format.html
      format.json {render json: @categories}
    end
  end
end
