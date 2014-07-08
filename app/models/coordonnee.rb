class Coordonnee < ActiveRecord::Base
  belongs_to :coord_category

  validates :libelle, presence: true
  validates :content, presence: true
end
