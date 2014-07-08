class AddAncestryToCoordCategories < ActiveRecord::Migration
  def change
    add_column :coord_categories, :ancestry, :string
    add_index :coord_categories, :ancestry
  end
end
