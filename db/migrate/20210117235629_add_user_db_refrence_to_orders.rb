class AddUserDbRefrenceToOrders < ActiveRecord::Migration[6.1]
  def change
  	add_reference :orders, :user_db
  end
end
