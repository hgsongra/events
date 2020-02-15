class CreateMeetings < ActiveRecord::Migration[6.0]
  def change
    create_table :meetings do |t|
      t.string :title
      t.text :description
      t.datetime :start_at
      t.datetime :end_at

      t.timestamps
    end
  end
end
