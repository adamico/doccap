class Admin::CommunicationsController < ApplicationController
  after_action :verify_authorized, except: :tags

  def tags
    the_tags = ActsAsTaggableOn::Tag.named_like(params[:q])
    @tags = the_tags.any? ? the_tags : [params[:q]]
  end

  def new
    @communication = Communication.new
    authorize @communication
  end

  def edit
    @communication = Communication.friendly.find(params[:id])
    authorize @communication
  end

  def create
    @communication = Communication.create(communication_params)
    authorize @communication
    respond_with @communication, location: admin_communications_url
  end

  def update
    @communication = Communication.friendly.find(params[:id])
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

  def communication_params
    params.require(:communication).permit(:title, :publication, :fichier_name,
                                          :fichier_url, :tag_list, :category_id,
                                          :state)
  end
end
