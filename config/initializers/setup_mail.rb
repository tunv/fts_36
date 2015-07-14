ActionMailer::Base.delivery_method = :smtp
ActionMailer::Base.smtp_settings = {
  address: "smtp.gmail.com",
  port: ENV["port"],
  domain: ENV["domain"],
  user_name: ENV["gmail_username"],
  password: ENV["gmail_password"],
  authentication: "plain",
  enable_starttls_auto: true
}
