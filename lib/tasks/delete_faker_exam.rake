desc "Remove faker exam not start"
task delete_faker_exam: :environment do
  Exam.faker_exam.destroy_all
end
