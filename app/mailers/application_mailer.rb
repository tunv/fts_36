class ApplicationMailer < ActionMailer::Base
  default from: Settings.user.mail
end
