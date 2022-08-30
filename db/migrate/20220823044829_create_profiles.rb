class CreateProfiles < ActiveRecord::Migration[7.0]
  def change
    create_table :profiles do |t|
      t.string :name
      t.datetime :birthday
      t.string :phone
      t.integer :lang, default: 0
      t.integer :user_id

      t.timestamps
    end
  end
end
