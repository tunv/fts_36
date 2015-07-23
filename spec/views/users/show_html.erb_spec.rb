require "rails_helper"

RSpec.describe "users/show.html.erb", type: :view do
  it "displays user details correctly" do
    assign(:user, FactoryGirl.create(:user))
    render
    expect(rendered).to include("nguyenvantu")
  end
end
