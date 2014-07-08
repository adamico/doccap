class Page < ActiveRecord::Base
  extend FriendlyId

  friendly_id :name, use: :slugged
  has_ancestry

  enum state: [:draft, :published]

  validates :name, presence: true, uniqueness: true

  def self.human_states
    [].tap do |result|
      states.each do |key, value|
        result << [I18n.t("activerecord.attributes.#{model_name.i18n_key}.states.#{key}"), key]
      end
    end
  end

  def to_s
    name
  end
end
