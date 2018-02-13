class CreateBooks < ActiveRecord::Migration[5.0]
  def change
    create_table :books do |t|
      t.integer :jpgno
      t.string :name
      t.integer :price
      t.string :publisher
      t.integer :level
      t.integer :hands
      t.integer :layout
      t.integer :const
      t.integer :page

      t.timestamps
    end
  end
end
