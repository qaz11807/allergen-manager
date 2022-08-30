class CreateMedicines < ActiveRecord::Migration[7.0]
  def change
    create_table :medicines do |t|
      t.string :name
      t.string :manufacture
      t.string :description
      t.datetime :expired_at
      t.integer :user_id

      t.timestamps
    end
  end
end
