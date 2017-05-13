class ChangeIntegerLimitInDvds < ActiveRecord::Migration[5.0]
  def change
    change_column :dvds, :upc, :integer, limit: 8
  end
end
