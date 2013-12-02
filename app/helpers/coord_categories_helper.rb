module CoordCategoriesHelper
  def nested_path(category)
    "/" + category.ancestors_and_self.map(&:to_param).join("/")
  end
end
