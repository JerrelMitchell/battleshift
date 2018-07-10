class ActivationNotifierMailer < ApplicationMailer
  def inform(user_email)
    mail(to: user_email, subject: "Welcome to Battleshift. Activate your account here!")
  end
end
