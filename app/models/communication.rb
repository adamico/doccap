class Communication
  include Mongoid::Document
  include Mongoid::Timestamps
  include Mongoid::Taggable

  field :t, as: :titre, type: String
  field :st, as: :slugged_titre, type: String
  field :p, as: :publication, type: Date
  field :pd, as: :published, type: String
  field :fu, as: :fichier_url, type: String
  field :fn, as: :fichier_name, type: String

  belongs_to :category

  validates :titre, presence: true, uniqueness: true
  validates :publication, presence: true
  validates :category_id, presence: true
  before_validation :generate_slugged_fields

  def is_published?
    published == "oui"
  end

  def self.published
    where(published: "oui")
  end

  def self.search(query)
    by_titre = published.where(slugged_titre: /.*#{query}.*/i)
    by_tag = tagged_with_any(query)
    return by_titre + by_tag
  end

  private

  def generate_slugged_fields
    self.slugged_titre ||= titre.parameterize
  end
end
