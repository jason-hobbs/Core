class ApplicationMailer < ActionMailer::Base
  default from: "no-reply@core.imtins.com"
  layout 'mailer'
end
