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
  before_validation :generate_slugged_fields

  def is_published?
    published == "oui"
  end

  private

  def generate_slugged_fields
    self.slugged_titre ||= titre.parameterize
  end
end
