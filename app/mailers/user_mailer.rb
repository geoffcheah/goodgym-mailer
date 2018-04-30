class UserMailer < ApplicationMailer

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.user_mailer.contact.subject
  #
  def contact(personalised_email, runner)
    @personalised_email = personalised_email
    @runner = runner
    mail(to: @runner.email , subject: "#{@personalised_email.subject}")
  end
end
