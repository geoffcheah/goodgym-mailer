class AddAttributesToRunners < ActiveRecord::Migration[5.1]
  def change
    add_column :runners, :group_run, :boolean, default: true
    add_column :runners, :mission, :boolean, default: false
    add_column :runners, :coach_run, :boolean, default: false
  end
end
