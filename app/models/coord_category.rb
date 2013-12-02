class CoordCategory
  include Mongoid::Document
  include Mongoid::Tree
  include Slug

  field :name
  field :slug

  def to_s
    name
  end
end
