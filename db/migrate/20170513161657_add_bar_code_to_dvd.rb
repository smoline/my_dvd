class AddBarCodeToDvd < ActiveRecord::Migration[5.0]
  def change
    add_column :dvds, :upc, :integer
  end
end
