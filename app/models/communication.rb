class Communication < ActiveRecord::Base
  acts_as_taggable

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
  #def self.search_by_titre_or_tag(query)
    #(self.by_titre(query) + self.by_tag(query)).uniq
  #end

  #def self.by_titre(query)
    #published.where(slugged_titre: /.*#{query}.*/i)
  #end

  #def self.by_tag(query)
    #published.tagged_with_any(/.*#{query}.*/i)
  #end
end
