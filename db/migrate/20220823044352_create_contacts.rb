class CreateContacts < ActiveRecord::Migration[7.0]
  def change
    create_table :contacts do |t|
      t.integer :user_id
      t.string :name
      t.string :phone
      t.string :description
      t.integer :order

      t.timestamps
    end
  end
end
