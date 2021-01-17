class AddRefrenceToOrders < ActiveRecord::Migration[6.1]
  def change
  	add_reference :orders, :product
  end
end
