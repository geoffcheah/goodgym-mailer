class PersonalisedEmailsController < ApplicationController
  def new
    @personalised_email = PersonalisedEmail.new
  end

  def create
    @runners = Runner.all
    @personalised_email = PersonalisedEmail.new(email_params)
    @personalised_email.user = current_user
    if @personalised_email.save
      target_status = @personalised_email.status
      @runners = filter_runners_for_status(@runners, target_status)
      @runners = filter_runners_for_preference(@runners, @personalised_email) if did_trainer_specify_preference?(@personalised_email)
      @runners.each do |runner|
        UserMailer.contact(@personalised_email, runner).deliver_now
      end
      flash[:notice] = "Email sent!"
      redirect_to(dashboard_path)
    else
      flash[:alert] = @personalised_email.errors.full_messages
      render 'new'
    end
  end

  private

  # strong params
  def email_params
    params.require(:personalised_email).permit(:subject, :content, :status, :group_run, :mission, :coach_run, :user_id)
  end

  # takes in personalised_email object the user (trainer) created. Method to verify whether user has targeted group runners (group_run boolean attribute)
  def contact_group_runners?(personalised_email)
    personalised_email.group_run
  end

  # Method to verify whether user (trainer) has targeted mission runners
  def contact_mission_runners?(personalised_email)
    personalised_email.mission
  end

  # Method to verify whether user (trainer) has targeted coach runners
  def contact_coach_runners?(personalised_email)
    personalised_email.coach_run
  end

  # Method to match the runners in area with the targetted status selected by user (trainer) for email contact
  def filter_runners_for_status(runners, target_status)
    runners.select { |runner| runner.status == target_status}
  end

  # Method to filter the selected runners with matching status down to select runners with users targeted preference
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

  # Method to determine whether user (trainer) wanted to target by preference. Logic for which @runners to send to when they do and do not
  def did_trainer_specify_preference?(personalised_email)
    return true if personalised_email.group_run || personalised_email.mission || personalised_email.coach_run
  end
end

# go through each runner
# find runners where status matches
# find each runner who has given preference through looking at their boolean attributes,
# use completely filtered @runners array to send bulk emails
