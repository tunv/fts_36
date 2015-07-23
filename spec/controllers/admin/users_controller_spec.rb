require "rails_helper"

RSpec.describe Admin::UsersController, type: :controller do
  include Devise::TestHelpers
  before :each do
    @admin = FactoryGirl.create :user, role: "admin"
    @normal = FactoryGirl.create :user, role: "normal"
    sign_in @admin
  end

  describe "GET index" do
    it "renders the :index template" do
      get :index
      expect(response).to render_template :index
    end
  end

  describe "PUT update/:id" do
    it do
      put :update, id: @normal.id, format: :js
      expect(response).to be_successful
    end
  end

  describe "DELETE #destroy" do
    it "should response index page after delete user" do
      delete :destroy, id: @normal.id
      expect(response).to redirect_to admin_users_path
    end
  end
end
