class AddMarkToExams < ActiveRecord::Migration
  def change
    add_column :exams, :mark, :string
    remove_column :exams, :max_time, :integer
  end
end
