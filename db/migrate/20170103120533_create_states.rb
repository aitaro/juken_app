class CreateStates < ActiveRecord::Migration[5.0]
  def change
    create_table :states do |t|
      t.string :year
      t.string :type
      t.string :university
      t.string :deviation
      t.string :time
      t.string :layout
      t.string :exercise
      
      t.timestamps
    end
  end
end
