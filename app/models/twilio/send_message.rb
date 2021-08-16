module Twilio
  class SendMessage
    def self.call(twilio_number, recipient, message)
      new(twilio_number, recipient, message).call
    end

    def initialize(twilio_number, recipient, message)
      @twilio_number = twilio_number
      @recipient = recipient
      @message = message
    end

    def call
      client.messages.create(
        from: @twilio_number,
        body: @message,
        to: @recipient
      )
    end

    private

    def client
      Twilio::REST::Client.new(ENV['TWILIO_ACCOUNT'], ENV['TWILIO_AUTH'])
    end
  end
end