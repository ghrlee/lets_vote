class VotesController < ApplicationController
  skip_before_action :verify_authenticity_token

  def create
    Twilio::Sms.call(params)
  end
end