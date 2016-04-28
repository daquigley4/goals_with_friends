class AddOwnerToGoals < ActiveRecord::Migration
  def change
    add_column :goals, :owner, :string
  end
end
