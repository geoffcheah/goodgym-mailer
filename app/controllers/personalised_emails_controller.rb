class PersonalisedEmailsController < ApplicationController
  def new
    @personalised_email = PersonalisedEmail.new
  end

  def create
    @runners = Runner.all
    @personalised_email = PersonalisedEmail.new(email_params)
    @personalised_email.user = current_user
    if @personalised_email.save
      SendWeeklyEmail.new(@personalised_email, @runners).call
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
end
# go through each runner
# find runners where status matches
# find each runner who has given preference through looking at their boolean attributes,
# use completely filtered @runners array to send bulk emails
