class PersonalisedEmailsController < ApplicationController

  def new
    @personalised_email = PersonalisedEmail.new
  end

  def create
    @runners = Runner.all
    @personalised_email = PersonalisedEmail.new(email_params)
    @personalised_email.user = current_user
    if @personalised_email.save!
      target_status = @personalised_email.status
      @runners = filter_runners_for_status(@runners, target_status)
      @runners = filter_runners_for_preference(@runners, @personalised_email) if did_trainer_specify_preference?(@personalised_email)
      @runners.each do |runner|
        UserMailer.contact(@personalised_email, runner).deliver_now
      end
      flash[:alert] = "Email sent!"
      redirect_to(root_path)
    else
      flash[:alert] = @personalised_email.errors.full_messages
      render 'new'
    end
  end

  private

  def email_params
    params.require(:personalised_email).permit(:subject, :content, :status, :group_run, :mission, :coach_run, :user_id)
  end

   def contact_group_runners?(personalised_email)
    personalised_email.group_run
  end

  def contact_mission_runners?(personalised_email)
    personalised_email.mission
  end

  def contact_coach_runners?(personalised_email)
    personalised_email.coach_run
  end

  def filter_runners_for_status(runners, target_status)
    runners.select { |runner| runner.status == target_status}
  end

  def filter_runners_for_preference(runners, personalised_email)
    if contact_group_runners?(personalised_email) && contact_mission_runners?(personalised_email) && contact_coach_runners?(personalised_email)
      runners
    elsif contact_group_runners?(personalised_email) && contact_mission_runners?(personalised_email)
      runners.delete_if { |runner| !runner.group_run && !runner.mission }
    elsif contact_group_runners?(personalised_email) && contact_coach_runners?(personalised_email)
      runners.delete_if { |runner| !runner.group_run && !runner.coach_run }
    elsif contact_mission_runners?(personalised_email) && contact_coach_runners?(personalised_email)
      runners.delete_if { |runner| !runner.mission && !runner.coach_run }
    elsif contact_group_runners?(personalised_email)
      runners.delete_if { |runner| !runner.group_run}
    elsif contact_mission_runners?(personalised_email)
      runners.delete_if { |runner| !runner.mission }
    else contact_coach_runners?(personalised_email)
      runners.delete_if { |runner| !runner.coach_run }
    end
  end

  def did_trainer_specify_preference?(personalised_email)
    return true if personalised_email.group_run || personalised_email.mission || personalised_email.coach_run
  end
end

# go through each runner
# find runners where status matches
# put runners in separate array to iterate over
# find each runner who has given preference through looking at their boolean attributes,
# use completely filtered runners array to send bulk emails
