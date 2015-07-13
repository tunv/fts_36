class ResultMailer < ApplicationMailer
  def result_exam exam
    @exam = exam
    mail to: exam.user.email, subject: t("result_mail")
  end
end
