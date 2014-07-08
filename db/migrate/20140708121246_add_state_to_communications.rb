class AddStateToCommunications < ActiveRecord::Migration
  def change
    add_column :communications, :state, :integer, default: 0
  end
end
