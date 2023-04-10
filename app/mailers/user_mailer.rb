class UserMailer < ApplicationMailer
  def signup_email(user)
    @user = user
    mail(to: @user.email, subject: 'Welcome to MyApp!')
  end
end
