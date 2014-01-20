# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :unpublished_communication, class: "Communication" do
    sequence(:titre) {|n| "unpublished comm#{n}"}
    publication Date.today
    category
    factory :communication do
      sequence(:titre) {|n| "comm#{n}"}
      published "oui"
    end
  end
end
