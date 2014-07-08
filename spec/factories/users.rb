FactoryGirl.define do
  factory :user do
    sequence(:email) { |n| "user#{n}@example.com" }
    password "mypassword01"
    password_confirmation "mypassword01"

    factory :approved_user do
      state 'approved'

      factory :admin do
        sequence(:email) { |n| "admin#{n}@example.com" }
        after(:create) { |user| user.add_role(:admin) }
      end
    end
  end
end
