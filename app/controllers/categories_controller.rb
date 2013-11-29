class CategoriesController < ApplicationController
  def index
    @categories = Category.where(name: /.*#{params[:q]}.*/i).asc(:name)
    respond_to do |format|
      format.json { render json: @categories.map(&:name_and_id) }
    end
  end

  def new
    @category = Category.new
    respond_to do |format|
      format.html
      format.js { render layout: false}
    end
  end

  def create
    @category = Category.new(category_params)
    if @category.save
      respond_to do |format|
        format.html { redirect_with_flash @category, nil, :success, "Le category #{@category.fullname} a été créé." }
        format.js { render json: {id: @category.id, label: @category.name } }
      end
    else
      respond_to do |format|
        format.html { render :new }
        format.js { render layout: false, status: :not_acceptable }
      end
    end
  end

  def edit
    @category = Category.find(params[:id])
    respond_to do |format|
      format.html
      format.js { render layout: false}
    end
  end

  def update
    @category = Category.find(params[:id])
    if @category.update(category_params)
      respond_to do |format|
        format.html { redirect_with_flash @category, nil, :success, "La catégorie #{@category.name} a été mise à jour avec succès."}
        format.js { render json: {id: @category.id, label: @category.name}}
      end
    else
      respond_to do |format|
        format.html { render :edit }
        format.js { render :edit, layout: false, status: :not_acceptable }
      end
    end
  end

  private

  def category_params
    params.require(:category).permit(:name)
  end
end
