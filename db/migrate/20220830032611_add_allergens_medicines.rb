class AddAllergensMedicines < ActiveRecord::Migration[7.0]
  def change
    create_table :allergen_medicines do |t|
      t.references :allergen, null: false, foreign_key: true
      t.references :medicine, null: false, foreign_key: true

      t.timestamps
    end
  end
end
