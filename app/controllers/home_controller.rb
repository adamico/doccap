class HomeController < ApplicationController
  respond_to :js, only: :search

  def index
  end

  def biblio
  end

  def search
    vigitox = "http://vigitox.herokuapp.com"
    @vigitox = vigitox
    @articles = HTTParty.get("#{@vigitox}/api/v1/articles?q=#{params['query']}")
    @communications_by_category = Communication.search(params['query']).group_by {|comm| comm.category.name }
  end
end
