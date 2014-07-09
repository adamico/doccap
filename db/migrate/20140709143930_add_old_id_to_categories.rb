class AddOldIdToCategories < ActiveRecord::Migration
  def change
    add_column :categories, :old_id, :string
  end
end
