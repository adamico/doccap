# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :communication do
    sequence(:titre) {|n| "communication#{n}"}
    publication Date.today
  end
end
