class CreateGoals < ActiveRecord::Migration
  def change
    create_table :goals do |t|
      t.string :title, null: false
      t.date :due_date, null: false
      t.boolean :completed, null: false

      t.timestamps null: false
    end
  end
end
