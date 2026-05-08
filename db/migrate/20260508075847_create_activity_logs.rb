class CreateActivityLogs < ActiveRecord::Migration[8.0]
  def change
    create_table :activity_logs do |t|
      t.string :action
      t.string :trackable_type
      t.integer :trackable_id
      t.text :details

      t.timestamps
    end
  end
end
