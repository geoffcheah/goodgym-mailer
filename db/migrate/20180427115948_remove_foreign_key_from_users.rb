class RemoveForeignKeyFromUsers < ActiveRecord::Migration[5.1]
  def change
    remove_reference :users, :areas, index: true
  end
end
