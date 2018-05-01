class PagesController < ApplicationController
  skip_before_action :authenticate_user!, only: [:home]

  def home
  end

  def dashboard
    @personalised_emails = PersonalisedEmail.all
  end
end
