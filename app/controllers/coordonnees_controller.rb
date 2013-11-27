class CoordonneesController < ApplicationController
  respond_to :html, :json
  responders :flash, :http_cache
  load_and_authorize_resource

  def new
  end

  def index
    @coordonnees = Coordonnee.includes(:coord_category).asc(:libelle)
  end

  def create
    @coordonnee = Coordonnee.create(coordonnee_params)
    respond_with @coordonnee, location: coordonnees_url
  end

  def coordonnee_params
    params.require(:coordonnee).permit(:libelle, :coord_category_id)
  end
end
