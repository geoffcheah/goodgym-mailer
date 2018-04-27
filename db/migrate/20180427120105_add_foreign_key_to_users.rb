class AddForeignKeyToUsers < ActiveRecord::Migration[5.1]
  def change
    add_reference :users, :area, index: true
  end
end
