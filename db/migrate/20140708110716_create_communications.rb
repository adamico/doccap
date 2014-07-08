class CreateCommunications < ActiveRecord::Migration
  def change
    create_table :communications do |t|
      t.string :fichier_name
      t.string :fichier_url
      t.date :publication
      t.string :title
      t.string :slug

      t.timestamps
    end
    add_index :communications, :slug, unique: true
  end
end
