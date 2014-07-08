FactoryGirl.define do
  factory :page do
    sequence(:name) {|n| "page#{n}"}
    factory :published do
      sequence(:name) {|n| "published#{n}"}
      state 'published'
    end
    factory :draft do
      sequence(:name) {|n| "draft#{n}"}
      state 'draft'
    end
  end
end
