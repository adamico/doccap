class CommunicationsController < ApplicationController
  load_and_authorize_resource

  def tags
    @tags = Communication.tags.select {|tag| tag =~ /#{params[:q]}/i}
  end

  def index
    @communications = Communication.scoped
  end

  def show
  end

  def new
  end

  def edit
  end

  def create
    @communication = Communication.new(communication_params)

    respond_to do |format|
      if @communication.save
        format.html { redirect_to @communication, notice: 'Communication was successfully created.' }
        format.json { render action: 'show', status: :created, location: @communication }
      else
        format.html { render action: 'new' }
        format.json { render json: @communication.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /communications/1
  # PATCH/PUT /communications/1.json
  def update
    respond_to do |format|
      if @communication.update(communication_params)
        format.html { redirect_to @communication, notice: 'Communication was successfully updated.' }
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
    params.require(:communication).permit(:titre, :publication, :fichier, :remove_file, :tags, :category_id, :published)
  end
end
