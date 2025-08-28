class CreateReactions < ActiveRecord::Migration[7.2]
  def change
    create_table :reactions do |t|
      t.references :subject, polymorphic: true, null: false
      t.timestamps
    end
  end
end
