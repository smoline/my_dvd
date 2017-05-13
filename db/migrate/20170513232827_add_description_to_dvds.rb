class AddDescriptionToDvds < ActiveRecord::Migration[5.0]
  def change
    add_column :dvds, :description, :string
  end
end
