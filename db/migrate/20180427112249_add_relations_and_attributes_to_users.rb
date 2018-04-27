class AddRelationsAndAttributesToUsers < ActiveRecord::Migration[5.1]
  def change
    add_reference :users, :areas, index: true
    add_column :users, :first_name, :string
    add_column :users, :last_name, :string
  end
end
