class PersonalisedEmailsController < ApplicationController

  def new
    @personalised_email = PersonalisedEmail.new
  end

  def create
    @runners = Runner.all
    @personalised_email = PersonalisedEmail.new(email_params)
    if @personalised_email.save!
      UserMailer.contact(@personalised_email, @runners).deliver_now
      flash[:notice] = "Email sent!"
    else
      flash[:errors] = @personalised_email.errors.full_messages
      render 'new'
    end
  end

  private

  def email_params
    params.require(:personalised_email).permit(:subject, :content, :status, :group_run, :mission, :coach_run, :user_id)
  end
end
