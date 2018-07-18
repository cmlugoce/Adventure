class CreateTrails < ActiveRecord::Migration
  def change
    create_table :trails do |t|
      t.string :name
      t.string :location
      t.string :date
      t.string :notes
      t.integer :distance
      t.integer :user_id
    end
  end
end
