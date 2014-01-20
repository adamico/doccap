class PagesController < ApplicationController
  skip_before_action :authenticate_user!

  def show
    path = request.fullpath.split("/").reject {|item| item.blank? || ["admin", "pages"].include?(item)}
    scope = current_user && current_user.admin? ? Page : Page.published
    @page = scope.where(slug: path.last).first if path.all? {|page| Page.where(slug: page).first}
    render :not_found unless @page
  end

  def not_found
  end
end
