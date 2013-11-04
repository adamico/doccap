require 'spec_helper'

describe PagesHelper do
  describe "#nested_page_path" do
    let(:gfather) {create(:page, name: "gfather")}
    let(:father) {create(:page, name: "father", parent: gfather)}
    let(:child) {create(:page, name: "child", parent: father)}
    it "should return the joined ancestors name with '/'" do
      expect(helper.nested_page_path(child)).to eql("/gfather/father/child")
    end
  end
end
