class HomeController < ApplicationController
  respond_to :js, only: :search

  def index
  end

  def search
    vigitox = "http://vigitox.herokuapp.com"
    @vigitox = vigitox
    @articles = HTTParty.get("#{@vigitox}/api/v1/articles?q=#{params['query']}")
  end
end
