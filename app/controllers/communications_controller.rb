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
    respond_with @communication
  end

  # PATCH/PUT /communications/1
  # PATCH/PUT /communications/1.json
  def update
    respond_to do |format|
      if @communication.update(communication_params)
        format.html { redirect_to communications_url, notice: "Communication #{@communication.titre} was successfully updated." }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @communication.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /communications/1
  # DELETE /communications/1.json
  def destroy
    @communication.destroy
    respond_to do |format|
      format.html { redirect_to communications_url }
      format.json { head :no_content }
    end
  end

  private

  # Never trust parameters from the scary internet, only allow the white list through.
  def communication_params
    params.require(:communication).permit(:titre, :publication, :fichier_name, :fichier_url, :tags, :category_id, :published)
  end
end
