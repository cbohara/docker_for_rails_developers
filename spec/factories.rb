FactoryGirl.define do
  factory :user do
    sequence :email do |n|
      "dummy_email#{n}@example.com"
    end
    password "secret_password"
    password_confirmation "secret_password"
  end

  factory :company do
    name "Starbucks"
    association :user
  end
end
