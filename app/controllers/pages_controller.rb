class PagesController < ApplicationController
  before_action :set_page, only: :show
  load_and_authorize_resource
  rescue_from Mongoid::Errors::DocumentNotFound, with: :page_not_found

  def show
  end

  def current_page
    if self.class == PagesController
      path = request.fullpath.split("/").reject {|item| item.blank? || ["admin", "pages"].include?(item)}
      if path.all? {|page| Page.where(slug: page).first}
        if current_user && current_ability.can?(:access, :pages)
          @page = Page.where(slug: path.last).first
        else
          @page = Page.published.where(slug: path.last).first
        end
      end
    else
      nil
    end
  end

  private

  def set_page
    current_page
  end

  def page_not_found
    render template: "shared/not_found", status: 404
  end
end
