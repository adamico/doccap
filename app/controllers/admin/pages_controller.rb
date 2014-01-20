class Admin::PagesController < ApplicationController
  respond_to :html, :json
  responders :flash, :http_cache
  before_action :set_page, only: [:show, :edit, :update, :destroy]
  after_action :verify_authorized, except: :index

  def index
    @pages = Page.all
    respond_with @pages
  end

  def new
    @page = Page.new
    authorize @page
    respond_with @page
  end

  def edit
    authorize @page
    respond_with @page
  end

  def create
    @page = Page.create(page_params)
    authorize @page
    respond_with @page, location: admin_pages_url
  end

  def update
    @page.update(page_params)
    authorize @page
    respond_with @page, location: admin_pages_url
  end

  def destroy
    authorize @page
    @page.destroy
    respond_with @page, location: admin_pages_url
  end

  private

  def set_page
    @page = Page.find_by(slug: params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def page_params
    params.require(:page).permit(:name, :content, :parent_id, :published)
  end
end
