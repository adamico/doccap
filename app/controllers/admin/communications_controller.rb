class Admin::CommunicationsController < ApplicationController
  after_action :verify_authorized, except: [:index, :tags]
  after_action :verify_policy_scoped, only: :index

  def tags
    @tags = Communication.tags.select {|tag| tag =~ /#{params[:q]}/i}
  end

  def index
    @communications = policy_scope(Communication).includes(:category).desc(:publication)
  end

  def show
    @communication = Communication.find(params[:id])
    authorize @communication
  end

  def new
    @communication = Communication.new
    authorize @communication
  end

  def edit
    @communication = Communication.find(params[:id])
    authorize @communication
  end

  def create
    @communication = Communication.create(communication_params)
    authorize @communication
    respond_with @communication, location: admin_communications_url
  end

  def update
    @communication = Communication.find(params[:id])
    @communication.update(communication_params)
    authorize @communication
    respond_with @communication, location: admin_communications_url
  end

  def destroy
    @communication = Communication.find(params[:id])
    authorize @communication
    if destroy_fichier(@communication.fichier_url)
      @communication.destroy
      respond_with @communication, location: admin_communications_url
    else
      redirect_to admin_communications_url, alert: "Le document n'a pas été détruit car la destruction du fichier joint #{@communication.fichier_name} a échoué."
    end
  end

  private

  # Never trust parameters from the scary internet, only allow the white list through.
  def communication_params
    params.require(:communication).permit(:titre, :publication, :fichier_name, :fichier_url, :tags, :category_id, :published)
  end
end
