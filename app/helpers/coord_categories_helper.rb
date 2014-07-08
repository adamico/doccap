module CoordCategoriesHelper
  def nested_path(category)
    "/" + (category.ancestors + [category]).map(&:to_param).join("/")
  end
end
