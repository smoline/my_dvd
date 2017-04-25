class CreateDvds < ActiveRecord::Migration[5.0]
  def change
    create_table :dvds do |t|
      t.string :title
      t.string :disc_type

      t.timestamps
    end
  end
end
