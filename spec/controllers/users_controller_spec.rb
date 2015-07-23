require "rails_helper"

RSpec.describe UsersController, type: :controller do
  include Devise::TestHelpers
  before :each do
    @user = FactoryGirl.create :user, role: "admin"
    sign_in @user
  end

  describe "GET show" do
    it "renders the :show template" do
      get :show, id: @user.id
      expect(response).to render_template :show
    end
  end
end
