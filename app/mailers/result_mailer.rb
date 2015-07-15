class ResultMailer < ApplicationMailer
  def result_exam exam
    @exam = exam
    mail to: exam.user.email, subject: t("result_mail")
  end

  def remind_user exam
    @exam = exam
    mail to: @exam.user.email, subject: t("alert_mail")
  end
end
