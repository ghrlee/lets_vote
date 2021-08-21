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
      if sms.new_record?
        sms.destroy
        Twilio::SendMessage.call(@twilio_number, @recipient, "Voting reset. Send VOTE to start a new vote.")
      else
        Twilio::SendMessage.call(@twilio_number, @recipient, "You have no vote in progress")
      end
    end

    private

    def sms
      @sms ||= SmsConversation.find_by(twilio_number: @twilio_number, recipient: @recipient)
    end
  end
end