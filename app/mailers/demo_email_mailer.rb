class DemoEmailMailer < ApplicationMailer
  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.demo_email_mailer.user_count.subject
  #
  def user_count
    @greeting = "Hi greetings you recieved this email because you are subscribed to our service." 

    mail to: "to@example.org"
  end
end
