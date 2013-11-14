class Communication
  include Mongoid::Document
  include Mongoid::Timestamps
  include Mongoid::Taggable

  mount_uploader :fichier, FichierUploader

  field :t, as: :titre, type: String
  field :st, as: :slugged_titre
  field :p, as: :publication, type: Date
  field :pd, as: :published, type: Boolean

  belongs_to :category

  validates :titre, presence: true, uniqueness: true
  before_validation :generate_slugged_fields

  private

  def generate_slugged_fields
    self.slugged_titre ||= titre.parameterize
  end
end
