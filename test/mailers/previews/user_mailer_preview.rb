# Preview all emails at http://localhost:3000/rails/mailers/user_mailer
class UserMailerPreview < ActionMailer::Preview

  # Preview this email at http://localhost:3000/rails/mailers/user_mailer/contact
  def contact(personalised_email, runners)
    UserMailer.contact(personalised_email, runners)
  end

end
  UserMailer.contact(PersonalisedEmail.first, @runners)
