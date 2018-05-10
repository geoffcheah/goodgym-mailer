class SendWeeklyEmail
  def initialize(personalised_email, runners)
    @personalised_email = personalised_email
    @runners = runners
  end

  def call
    target_status = @personalised_email.status
    @runners = filter_runners_for_status(@runners, target_status)
    @runners = filter_runners_for_preference(@runners, @personalised_email) if did_trainer_specify_preference?(@personalised_email)
    @runners.each do |runner|
      UserMailer.contact(@personalised_email, runner).deliver_now
    end
  end

  private
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
    else
      runners.select do |runner|
        runner.mission == personalised_email.mission && runner.group_run == personalised_email.group_run && runner.coach_run == personalised_email.coach_run
      end
    end

    # elsif contact_group_runners?(personalised_email) && contact_mission_runners?(personalised_email)
    #   runners.delete_if { |runner| !runner.group_run && !runner.mission }
    # elsif contact_group_runners?(personalised_email) && contact_coach_runners?(personalised_email)
    #   runners.delete_if { |runner| !runner.group_run && !runner.coach_run }
    # elsif contact_mission_runners?(personalised_email) && contact_coach_runners?(personalised_email)
    #   runners.delete_if { |runner| !runner.mission && !runner.coach_run }
    # elsif contact_group_runners?(personalised_email)
    #   runners.delete_if { |runner| !runner.group_run}
    # elsif contact_mission_runners?(personalised_email)
    #   runners.delete_if { |runner| !runner.mission }
    # else contact_coach_runners?(personalised_email)
    #   runners.delete_if { |runner| !runner.coach_run }
    # end
  end





  # Method to determine whether user (trainer) wanted to target by preference. Logic for which @runners to send to when they do and do not
  def did_trainer_specify_preference?(personalised_email)
    return true if personalised_email.group_run || personalised_email.mission || personalised_email.coach_run
  end


end
