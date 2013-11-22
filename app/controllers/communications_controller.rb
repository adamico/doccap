class CommunicationsController < ApplicationController
  respond_to :html, :json
  responders :flash, :http_cache
  load_and_authorize_resource

  def tags
    @tags = Communication.tags.select {|tag| tag =~ /#{params[:q]}/i}
  end

  def index
    @communications = Communication.includes(:category).desc(:publication)
  end

  def show
  end

  def new
  end

  def edit
  end

  def create
    @communication = Communication.create(communication_params)
    respond_with @communication, location: communications_url
  end

  def update
    @communication.update(communication_params)
    respond_with @communication, location: communications_url
  end

  def destroy
    if destroy_fichier(@communication.fichier_url)
      @communication.destroy
      respond_with @communication, location: communications_url
    else
      redirect_to communications_url, alert: "Le document n'a pas été détruit car la destruction du fichier joint #{@communication.fichier_name} a échoué."
    end
  end

  private

  # Never trust parameters from the scary internet, only allow the white list through.
  def communication_params
    params.require(:communication).permit(:titre, :publication, :fichier_name, :fichier_url, :tags, :category_id, :published)
  end
end
