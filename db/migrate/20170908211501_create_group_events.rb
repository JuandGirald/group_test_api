class CreateGroupEvents < ActiveRecord::Migration[5.1]
  def change
    create_table :group_events do |t|
      t.date :start_date
      t.date :end_date
      t.integer :duration
      t.string :name
      t.text :description
      t.string :location
      t.string :status, default: '1'

      t.timestamps
    end
  end
end
