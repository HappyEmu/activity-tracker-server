class CreateAccelerations < ActiveRecord::Migration
  def change
    create_table :accelerations do |t|
      t.datetime :timestamp
      t.float :ax
      t.float :ay
      t.float :az
    end
  end
end
