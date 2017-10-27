class CreateUserSessions < ActiveRecord::Migration[5.1]
  def change
    create_table :user_sessions do |t|
      t.integer :user_id, null: false
      t.integer :session_id, null:false

      t.timestamps
    end

    add_index :user_sessions, :user_id
    add_index :user_sessions, :session_id, unique: true

  end
end
