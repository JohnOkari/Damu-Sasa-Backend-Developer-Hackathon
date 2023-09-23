class CreateServices < ActiveRecord::Migration[7.0]
  def change
    create_table :services do |t|
      t.string :specialist
      t.string :option
      t.integer :duration

      t.timestamps
    end
  end
end
