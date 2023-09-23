class CreatePrescriptions < ActiveRecord::Migration[7.0]
  def change
    create_table :prescriptions do |t|
      t.integer :patient_id
      t.integer :doctor_id
      t.integer :appointment_id
      t.string :medication
      t.text :instructions

      t.timestamps
    end
  end
end
