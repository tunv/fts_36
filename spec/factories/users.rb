FactoryGirl.define do
  factory :user do
    name "nguyenvantu"
    sequence :email do |n|
      "ggbondkaty#{n}@gmail.com"
    end
    password "12345678"
    password_confirmation "12345678"
  end
end
