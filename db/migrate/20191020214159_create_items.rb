class CreateItems < ActiveRecord::Migration
  def change
    create_table :items do |t|
      t.string :title
      t.integer :user_id
      t.text :notes

      t.timestamps null: false
    end
  end
end
