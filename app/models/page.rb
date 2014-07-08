class Page < ActiveRecord::Base
  extend FriendlyId

  friendly_id :name, use: :slugged
  has_ancestry

  enum state: [:draft, :published]

  validates :name, presence: true, uniqueness: true

  def to_s
    name
  end
end
