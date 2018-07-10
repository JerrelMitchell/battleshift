require 'rails_helper'

RSpec.describe ActivationNotifierMailer do
  it 'should contain correct content when sent' do
    recipient = User.create(email: 'example@example.com', name: 'Example', password: 'supersecret')
    email = ActivationNotifierMailer.inform(recipient)
    email_link = /Welcome to Battleshift. Activate your account here!/

    expect(email.from).to eq(['no-reply@example.com'])
    expect(email.to).to eq([recipient.email])
    expect(email.subject).to eq('Welcome to Battleshift. Activate your account here!')
    expect(email.html_part.body).to match(email_link)
  end
end
