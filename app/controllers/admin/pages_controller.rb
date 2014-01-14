class Admin::PagesController < ApplicationController
  before_action :set_page, only: [:show, :edit, :update, :destroy]
  load_and_authorize_resource
  rescue_from Mongoid::Errors::DocumentNotFound, with: :page_not_found

  def index
  end

  def new
  end

  def edit
  end

  def create
    @page = Page.new(page_params)

    if @page.save
      redirect_to admin_pages_url, notice: "Page '#{@page.name}' créée avec succès."
    else
      render action: 'new'
    end
  end

  def update
    if @page.update(page_params)
      redirect_to admin_pages_url, notice: "Page '#{@page.name}' mise à jour avec succès."
    else
      render action: 'edit'
    end
  end

  def destroy
    @page.destroy
    redirect_to admin_pages_url, notice: "Page '#{@page.name}' détruite avec succès."
  end

  private

  def page_not_found
    render template: "shared/not_found", status: 404
  end

  def set_page
    @page = Page.find_by(slug: params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def page_params
    params.require(:page).permit(:name, :content, :parent_id, :published)
  end
end
