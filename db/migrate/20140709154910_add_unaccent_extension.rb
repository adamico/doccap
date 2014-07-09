class AddUnaccentExtension < ActiveRecord::Migration
  def up
    execute "create extension if not exists unaccent"
  end

  def down
    execute "drop extension unaccent"
  end
end
