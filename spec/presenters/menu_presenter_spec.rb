require "spec_helper"
require "menu_presenter"

describe MenuPresenter do
  (1..3).each do |i|
    let(:"root#{i}") {create(:published, name: "root#{i}")}
  end

  let(:root_pages) {[root1, root2, root3]}
  let(:child_of_root1) {create(:published, name: "child_of_root1", parent: root1)}
  let(:draft_page) {create(:draft, name: "brouillon")}
  let(:presenter) {MenuPresenter.new(root_pages, view)}

  describe "#new" do
    it "accepts a pages collection and a view context" do
      expect(presenter.roots).to eq(root_pages)
      expect(presenter.context).to eq(view)
    end
  end

  describe "#to_html" do
    it "builds a ul.nav container" do
      expect(presenter.to_html).to match(/<ul class="nav" role="navigation">/)
    end

    it "populates the ul container with li using root pages collection" do
      root_pages.map(&:name).each do |name|
        expect(presenter.to_html).to match(/<li><a href="\/#{name}">#{name}/)
      end
    end

    it "populates each li item with nested ul for page children if any" do
      root1.children.should == [child_of_root1]
      expect(presenter.to_html).to match(/<li class="dropdown"><a class="dropdown-toggle" data-toggle="dropdown" href="#" id="root1">root1 <b class='caret'><\/b><\/a><ul class="dropdown-menu" role="navigation"><li><a href="\/root1\/child_of_root1">/)
    end

    it "doesn't render menu item for draft pages" do
      presenter.to_html.should_not match(/<li><a href="\/brouillon">/)
    end

    it "highlights menu branch if it matches current page" do
      controller.request.path = "/root2"
      expect(presenter.to_html).to match(/<li class="active"><a href="\/root2">root2/)
    end
  end
end
