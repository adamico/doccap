class CreatePages < ActiveRecord::Migration
  def change
    create_table :pages do |t|
      t.text :content
      t.string :name
      t.integer :state, default: 0
      t.string :slug

      t.timestamps
    end
    add_index :pages, :slug, unique: true
  end
end
