class AddTokenToToken < ActiveRecord::Migration[6.1]
  def change
  	add_column :tokens, :token, :string
  end
end
