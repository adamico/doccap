class CommunicationsController < ApplicationController
  respond_to :html, :json
  after_action :verify_authorized, only: :show
  after_action :verify_policy_scoped, only: :index

  def index
    @communications = policy_scope(Communication).order('publication desc')
    respond_with @communications
  end

  def show
    @communication = Communication.friendly.find(params[:id])
    authorize @communication
    respond_with @communication
  end
end
