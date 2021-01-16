class CreateUserDbs < ActiveRecord::Migration[6.1]
  def change
    create_table :user_dbs do |t|

      t.timestamps
    end
  end
end
