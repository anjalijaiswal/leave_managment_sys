class CreateUserTimes < ActiveRecord::Migration
  def change
    create_table :user_times do |t|
      t.integer :user_hour
      t.datetime :login_time
      t.datetime :logout_time
      t.references :user, index: true

      t.timestamps
    end
  end
end
