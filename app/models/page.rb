class Page
  include Mongoid::Document
  include Mongoid::Timestamps
  include Mongoid::Tree
  include Slug

  field :name, type: String
  field :slug, type: String
  field :content, type: String
  field :published, default: "non"

  validates :name, presence: true, uniqueness: true

  def self.published
    where(published: "oui")
  end

  def draft?
    published == "non"
  end

  def to_s
    name
  end
end
