class CreateActivities < ActiveRecord::Migration
  def change
    create_table :activities do |t|
      t.datetime :timestamp
      t.string :type_string
    end
  end
end
