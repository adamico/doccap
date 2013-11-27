# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :coordonnee do
    sequence(:libelle) {|i| "coordonnee#{i}"}
    content "<i>le content</i>"
    coord_category nil
  end
end
