FactoryGirl.define do
  factory :user do
    sequence(:email) {|n| "user#{n}@example.com"}
    password "mypassword01"
    password_confirmation "mypassword01"

    factory :admin do
      sequence(:email) {|n| "admin#{n}@example.com"}
      admin true
    end
  end
end
