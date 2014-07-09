class PrivateController < ApplicationController
  respond_to :js, only: :search

  def biblio
  end

  def search
    vigitox = "http://vigitox.herokuapp.com"
    @vigitox = vigitox
    @communications_by_category = Communication.search(params[:query])
      .group_by { |comm| comm.category.name }
    @articles = HTTParty
      .get("#{@vigitox}/api/v1/articles?q=#{params['query'].parameterize}")
    logger.info 'foo'
  end
end
