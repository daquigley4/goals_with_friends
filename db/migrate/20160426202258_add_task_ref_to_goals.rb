class AddTaskRefToGoals < ActiveRecord::Migration
  def change
    add_reference :goals, :task, index: true, foreign_key: true#, null: false
  end
end
