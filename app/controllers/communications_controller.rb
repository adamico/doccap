class CommunicationsController < ApplicationController
  respond_to :html
  responders :flash, :http_cache
  after_action :verify_authorized, only: :show

  def show
    @communication = Communication.find(params[:id])
    authorize @communication
  end
end
