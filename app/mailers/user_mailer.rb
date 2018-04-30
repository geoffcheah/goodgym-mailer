class UserMailer < ApplicationMailer

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.user_mailer.contact.subject
  #
  def contact(personalised_email, runners)
    @personalised_email = personalised_email
    @runners = runners
    target_status = @personalised_email.status
    @runners = filter_runners_for_status(@runners)
    @runners = filter_runners_for_preference(@runners, @personalised_email)

    @runners.each do |runner|
      @runner = runner
      mail(to: @runner.email , subject: "#{@personalised_email.subject}")
    end
  end

  private

  def contact_group_runners?(personalised_email)
    personalised_email.group_run
  end

  def contact_mission_runners?(personalised_email)
    personalised_email.mission_runners
  end

  def contact_coach_runners?(personalised_email)
    personalised_email.coach_run
  end

  def filter_runners_for_status(runners)
    runners.select { |runner| runner.status == target_status}
  end

  def filter_runners_for_preference(runners, personalised_email)
    if contact_group_runners?(personalised_email)
      runners.delete_if { |runner| !runner.group_run }
    elsif contact_mission_runners?(personalised_email)
      runners.delete_if { |runner| !runner.mission }
    else contact_coach_runners?(personalised_email)
      runners.delete_if { |runner| !runner.coach_run }
    end
  end
end

# go through each runner
# find runners where status matches
# put runners in separate array to iterate over
# find each runner who has given preference through looking at their boolean attributes,
# altering runners array which is returned to runners_to_send_to