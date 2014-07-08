module PagesHelper
  def nested_page_path(page)
    "/" + ([page] + page.ancestors).reverse.map(&:to_param).join("/")
  end
end
