class CreateUsers < ActiveRecord::Migration[7.2]
  def change
    create_table :users do |t|
      t.string :name
      t.string :email
      t.string :state, null: false
      t.datetime :state_changed_at
      t.timestamps
    end
  end
end
