class CreatePersonalisedEmails < ActiveRecord::Migration[5.1]
  def change
    create_table :personalised_emails do |t|
      t.string :subject
      t.text :content
      t.string :status
      t.boolean :group_run
      t.boolean :mission
      t.boolean :coach_run
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
