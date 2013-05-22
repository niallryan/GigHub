class CreateUserEventAttendances < ActiveRecord::Migration
  def change
    create_table :user_event_attendances do |t|
      t.integer :user_id
      t.integer :event_id

      t.timestamps
    end

    add_index :user_event_attendances, [:user_id, :event_id]
  end
end
