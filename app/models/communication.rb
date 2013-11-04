class Communication
  include Mongoid::Document
  include Mongoid::Timestamps
  include Mongoid::Paperclip
  include Mongoid::Taggable

  has_mongoid_attached_file :fichier,
    storage: :dropbox, dropbox_credentials: Rails.root.join("config/dropbox.yml")

  field :t, as: :titre, type: String
  field :st, as: :slugged_titre
  field :p, as: :publication, type: Date

  belongs_to :category

  validates :titre, presence: true, uniqueness: true
  before_validation :generate_slugged_fields

  attr_accessor :remove_file
  before_save :perform_remove_file

  private

  def generate_slugged_fields
    self.slugged_titre ||= titre.parameterize
  end

  def perform_remove_file
    self.fichier = nil if self.remove_file && !self.fichier.dirty?
  end
end
