module Vote
  class Exit
    def self.call(twilio_number, recipient)
      new(twilio_number, recipient).call
    end

    def initialize(twilio_number, recipient)
      @twilio_number = twilio_number
      @recipient = recipient
    end

    def call
      if sms
        sms.destroy
        poll.destroy if poll
        Twilio::SendMessage.call(@twilio_number, @recipient, "Voting reset. Send VOTE to start a new vote.")
      else
        Twilio::SendMessage.call(@twilio_number, @recipient, "You have no vote in progress")
      end
    end

    private

    def sms
      @sms ||= SmsConversation.find_by(twilio_number: @twilio_number, recipient: @recipient)
    end

    def poll
      @poll ||= Poll.find_by(sender_number: @recipient)
    end
  end
end