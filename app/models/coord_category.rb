class CoordCategory < ActiveRecord::Base
  #include Mongoid::Tree
  #include Slug

  def to_s
    name
  end
end
