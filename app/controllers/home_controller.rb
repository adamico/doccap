class HomeController < ApplicationController
  respond_to :js, only: :search
  def index
  end

  def search
  end
end
