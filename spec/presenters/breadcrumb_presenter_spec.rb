require "spec_helper"
require "breadcrumb_presenter"

describe BreadcrumbPresenter do
  let!(:gfather)   {create(:published, name: "gfather")}
  let!(:father)    {create(:published, name: "father", parent: gfather)}
  let!(:page)      {create(:published, name: "child", parent: father)}
  let!(:presenter) {BreadcrumbPresenter.new(page, view)}

  describe "#new" do
    it "accepts a view context" do
      expect(presenter.context).to eq(view)
    end
  end

  describe "#to_html" do
    it "builds a ul.breadcrumb container" do
      expect(presenter.to_html).to match /<ul class="breadcrumb">/
    end

    it "create a root crumb" do
      expect(presenter.to_html).to match /<li><a href="#{root_path}"><i class="icon-home"><\/i> Accueil/
    end

    it "creates crumbs from ancestors in reverse order" do
      expect(presenter.to_html).to match /<li><a href="\/gfather">gfather/
      expect(presenter.to_html).to match /<li><a href="\/gfather\/father">father/
      expect(presenter.to_html).to match /<li><a href="\/gfather\/father\/child">child/
    end

    it "crumbs should be properly separated" do
      expect(presenter.to_html).to match /<span class="divider">&gt;/
    end

    describe "for current page" do
      before do
        controller.request.path = "/gfather/father/child"
      end
      it "should not have divider after crumb" do
        presenter.to_html.should_not match /<li><a href="\/gfather\/father\/child">child<\/a><span class="divider">&gt;/
      end
      it "crumb should not have a link" do
        presenter.to_html.should match /<li>child/
      end
    end
  end
end
