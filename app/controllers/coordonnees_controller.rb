class CoordonneesController < ApplicationController
  respond_to :html, :json
  after_action :verify_authorized, except: :index
  after_action :verify_policy_scoped, only: :index

  def index
    @coordonnees = policy_scope(Coordonnee).order('libelle asc')
    respond_with @coordonnees

  end

  def show
    @coordonnee = Coordonnee.find(params[:id])
    authorize @coordonnee
    respond_with @coordonnee
  end
end
