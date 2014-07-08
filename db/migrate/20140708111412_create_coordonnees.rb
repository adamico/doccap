class CreateCoordonnees < ActiveRecord::Migration
  def change
    create_table :coordonnees do |t|
      t.string :libelle
      t.text :content
      t.belongs_to :coord_category, index: true

      t.timestamps
    end
  end
end
