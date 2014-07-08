class CoordCategory < ActiveRecord::Base
  extend FriendlyId

  friendly_id :name, use: :slugged
  has_ancestry

  default_scope { order(:name) }

  def to_s
    name
  end
end
