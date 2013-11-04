class Category
  include Mongoid::Document
  field :name, type: String

  has_many :communications

  validates :name, presence: true

  def to_s
    name
  end
end
