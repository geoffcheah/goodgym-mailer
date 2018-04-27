class DropPreferences < ActiveRecord::Migration[5.1]
  def change
    drop_table :preferences
  end
end
