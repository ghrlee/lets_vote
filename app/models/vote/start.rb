module Vote
  class Start
    def self.call(twilio_number, recipient)
      new(twilio_number, recipient).call
    end

    def initialize(twilio_number, recipient)
      @twilio_number = twilio_number
      @recipient = recipient
    end

    def call
      if sms.new_record?
        sms.save
        Twilio::SendMessage.call(@twilio_number, @recipient, "Enter a question to vote on")
      else
        Twilio::SendMessage.call(@twilio_number, @recipient, "You already have a session in progress")
      end
    end

    private

    def sms
      @sms ||= SmsConversation.find_or_initialize_by(twilio_number: @twilio_number, recipient: @recipient)
    end
  end
end