class UserMailer < ApplicationMailer
  # Mailer action that is called everytime a new instance of personalised_email is created by user
  def contact(personalised_email, runner)
    @personalised_email = personalised_email
    @runner = runner
    mail(to: @runner.email , subject: "#{@personalised_email.subject}")
  end
end
