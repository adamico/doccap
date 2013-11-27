class Coordonnee
  include Mongoid::Document
  field :libelle, type: String
  belongs_to :coord_category

  validates :libelle, presence: true
end
