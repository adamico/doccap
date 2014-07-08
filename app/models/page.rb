class Page < ActiveRecord::Base
  #include Mongoid::Tree
  #include Slug

  enum state: [:draft, :published]

  validates :name, presence: true, uniqueness: true

  def to_s
    name
  end
end
