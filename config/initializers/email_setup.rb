ActionMailer::Base.delivery_method = :smtp
ActionMailer::Base.smtp_settings = {
  address:              'smtp.gmail.com',
  port:                 587,
  domain:               'inspinia-dsa-production.herokuapp.com',
  user_name:            ENV["lincoln.inspinia.dsa"],
  password:             ENV["dljRy8k#{22}"],
  authentication:       'plain',
  enable_starttls_auto: true 
}