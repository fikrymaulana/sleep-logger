class CreateSleepRecords < ActiveRecord::Migration[7.1]
  def change
    create_table :sleep_records do |t|
      t.references :user, null: false, foreign_key: true
      t.timestamp :clock_in
      t.timestamp :clock_out
      t.integer :duration
      t.timestamp :deleted_at

      t.timestamps
    end
  end
end
