class CreateAttendances < ActiveRecord::Migration[5.0]
  def change
    create_table :attendances do |t|
      t.references :user, foreign_key: true
      t.date :for_date
      t.datetime :in_time
      t.datetime :out_time
      t.boolean :forced_leave
      t.boolean :leave_granted
      t.integer :hours_worked
      t.integer :break_hours

      t.timestamps
    end
  end
end
