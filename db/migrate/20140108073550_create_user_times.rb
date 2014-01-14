class CreateUserTimes < ActiveRecord::Migration
  def up
    create_table :user_times do |t|
      t.float :user_hour
      t.datetime :login_time
      t.datetime :logout_time
      t.references :user, index: true

      t.timestamps
    end
  end
  def down
  	drop_table :user_times
  end
end
