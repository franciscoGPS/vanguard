class UserMailer < ActionMailer::Base
  default from: "no-reply@vanguard.com.mx"


def welcome_email(user, generated_password)
    @user = user
    @url  = 'http://vanguard.com.mx/admin'
    @password0 = generated_password
    mail(to: @user.email, subject: 'Bienvenido a Vanguard!', password: @password0)
  end

end
