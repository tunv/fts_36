class CreateExams < ActiveRecord::Migration
  def change
    create_table :exams do |t|
      t.integer :max_time
      t.datetime :started_at
      t.references :category, index: true, foreign_key: true
      t.references :user, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
