class CreateCategories < ActiveRecord::Migration
  def change
    create_table :categories do |t|
      t.string :name
      t.integer :max_question
      t.integer :max_time

      t.timestamps null: false
    end
  end
end
