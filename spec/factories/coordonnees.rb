# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :coordonnee do
    sequence(:libelle) {|i| "coordonnee#{i}"}
    coord_category nil
  end
end
