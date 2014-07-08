class Admin::CoordonneesController < ApplicationController
  respond_to :html, :json
  responders :flash, :http_cache
  after_action :verify_authorized, except: :index
  after_action :verify_policy_scoped, only: :index

  before_action :set_coord_categories, only: [:new, :create, :edit, :update]

  def index
    @coordonnees = policy_scope(Coordonnee).includes(:coord_category).order(:libelle)
    respond_with @coordonnees
  end

  def show
    @coordonnee = Coordonnee.find(params[:id])
    authorize @coordonnee
    respond_with @coordonnee
  end

  def new
    @coordonnee = Coordonnee.new
    authorize @coordonnee
    respond_with @coordonnee
  end

  def create
    @coordonnee = Coordonnee.create(coordonnee_params)
    authorize @coordonnee
    respond_with @coordonnee, location: admin_coordonnees_url
  end

  def edit
    @coordonnee = Coordonnee.find(params[:id])
    authorize @coordonnee
    respond_with @coordonnee
  end

  def update
    @coordonnee = Coordonnee.find(params[:id])
    @coordonnee.update(coordonnee_params)
    authorize @coordonnee
    respond_with @coordonnee, location: admin_coordonnees_url
  end

  def destroy
    @coordonnee.destroy
    authorize @coordonnee
    respond_with @coordonnee, location: admin_coordonnees_url
  end

  private

  def coordonnee_params
    params.require(:coordonnee).permit(:libelle, :content, :coord_category_id)
  end

  def set_coord_categories
    @coord_categories ||= CoordCategory.all
  end
end
