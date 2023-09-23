class CreatePrescriptions < ActiveRecord::Migration[7.0]
  def change
    create_table :prescriptions do |t|
      t.string :user_id
      t.integer :appointment_id
      t.string :medication
      t.text :instructions

      t.timestamps
    end
  end
end
