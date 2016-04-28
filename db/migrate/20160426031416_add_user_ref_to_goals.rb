class AddUserRefToGoals < ActiveRecord::Migration
  def change
    add_reference :goals, :user, index: true, foreign_key: true, null: false
  end
end
