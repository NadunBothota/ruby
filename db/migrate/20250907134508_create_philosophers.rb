class CreatePhilosophers < ActiveRecord::Migration[8.0]
  def change
    create_table :philosophers do |t|
      t.string :phil_first_name, null: false
      t.string :phil_last_name, null: false
      t.integer :birth_year, null: false
      t.integer :death_year, null: true
      t.text :biography, null: true

      t.timestamps
    end
  end
end
