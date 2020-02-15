class CreateInvites < ActiveRecord::Migration[6.0]
  def change
    create_table :invites do |t|
      t.references :user
      t.references :meeting

      t.timestamps
    end
  end
end
