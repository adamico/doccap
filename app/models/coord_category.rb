class CoordCategory < ActiveRecord::Base
  #include Mongoid::Tree
  #include Slug
  #
  default_scope { order(:name) }

  def to_s
    name
  end
end
