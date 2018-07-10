class ActivationNotifierMailer < ApplicationMailer
  def inform(user)
    @user = user
    mail(to: user.email, subject: "Welcome to Battleshift. Activate your account here!")
  end
end
