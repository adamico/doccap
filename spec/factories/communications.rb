# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :unpublished_communication, class: "Communication" do
    sequence(:title) {|n| "unpublished comm#{n}"}
    publication Date.today
    category
    factory :communication do
      sequence(:title) {|n| "comm#{n}"}
      state 'published'
    end
  end
end
