class CreateMemberships < ActiveRecord::Migration[5.1]
  def change
    create_table :memberships do |t|
      t.references :preference, foreign_key: true
      t.references :runner, foreign_key: true

      t.timestamps
    end
  end
end
