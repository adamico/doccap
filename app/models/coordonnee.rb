class Coordonnee
  include Mongoid::Document
  field :libelle, type: String
  field :content, type: String
  belongs_to :coord_category

  validates :libelle, presence: true
  validates :content, presence: true
end
