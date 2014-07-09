class Communication < ActiveRecord::Base
  extend FriendlyId
  include PgSearch
  acts_as_taggable

  friendly_id :title, use: :slugged

  belongs_to :category

  validates :title, presence: true, uniqueness: true
  validates :publication, presence: true
  validates :category_id, presence: true

  enum state: [:draft, :published]

  def self.human_states
    [].tap do |result|
      states.each do |key, value|
        result << [I18n.t("activerecord.attributes.#{model_name.i18n_key}.states.#{key}"), key]
      end
    end
  end

  pg_search_scope :text_search, against: :title,
                                associated_against: { tags: :name },
                                using: { tsearch: {
                                  prefix: true,
                                  dictionary: 'french' }
                                },
                                ignoring: :accents

  def self.search(query)
    text_search(query) if query.present?
  end
end
