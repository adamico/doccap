module PagesHelper
  def nested_page_path(page)
    "/" + page.ancestors_and_self.map(&:to_param).join("/")
  end
end
