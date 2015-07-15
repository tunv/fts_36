class RemindUserWorker
  include Sidekiq::Worker

  def perform exam_id
    exam = Exam.find exam_id
    ResultMailer.remind_user(exam).deliver unless exam.status == Settings.user.view
  end
end
