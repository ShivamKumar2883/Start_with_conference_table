class UserMailer < ApplicationMailer
  default from: 'no-reply@yourdomain.com'

  def welcome_email(user)
    @user = user
    @login_url = Rails.application.routes.url_helpers.login_url
    mail(to: @user.email, subject: 'Welcome to Our App!')
  end
end