class CreateUsers < ActiveRecord::Migration
  def up
    create_table :users do |t|
      t.string :name
      t.string :screen_name
      t.string :auth_hash
      t.timestamps
    end
  end

  def down
    drop_table :users
  end
end
