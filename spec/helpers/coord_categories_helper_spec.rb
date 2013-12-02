require 'spec_helper'

describe CoordCategoriesHelper do
  describe "#nested_path" do
    let(:gfather) {create(:coord_category, name: "gfather")}
    let(:father) {create(:coord_category, name: "father", parent: gfather)}
    let(:child) {create(:coord_category, name: "child", parent: father)}
    it "should return the joined ancestors name with '/'" do
      expect(helper.nested_path(child)).to eql("/gfather/father/child")
    end
  end
end
