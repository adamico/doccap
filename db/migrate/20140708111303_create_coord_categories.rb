class CreateCoordCategories < ActiveRecord::Migration
  def change
    create_table :coord_categories do |t|
      t.string :name
      t.string :slug

      t.timestamps
    end
    add_index :coord_categories, :slug, unique: true
  end
end
