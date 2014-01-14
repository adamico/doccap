FactoryGirl.define do
  factory :page do
    sequence(:name) {|n| "page#{n}"}
    factory :published do
      sequence(:name) {|n| "published#{n}"}
      published "oui"
    end
    factory :draft do
      sequence(:name) {|n| "draft#{n}"}
      published "non"
    end
  end
end
