class AddStatusToExams < ActiveRecord::Migration
  def change
    add_column :exams, :status, :string
  end
end
