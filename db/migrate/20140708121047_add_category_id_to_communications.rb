class AddCategoryIdToCommunications < ActiveRecord::Migration
  def change
    add_reference :communications, :category, index: true
  end
end
