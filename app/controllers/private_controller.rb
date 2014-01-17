class PrivateController < ApplicationController
  respond_to :js, only: :search

  def biblio
  end

  def search
    vigitox = "http://vigitox.herokuapp.com"
    @vigitox = vigitox
    @communications_by_category = Communication.search_by_titre_or_tag(params['query']).group_by {|comm| comm.category.name }
    @articles = HTTParty.get("#{@vigitox}/api/v1/articles?q=#{params['query'].parameterize}")
  end
end
