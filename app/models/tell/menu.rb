module Tell
  class Menu
    def self.call(twilio_number, recipient)
      new(twilio_number, recipient).call
    end

    def initialize(twilio_number, recipient)
      @twilio_number = twilio_number
      @recipient = recipient
    end

    def call
      message = <<~EOS
        MENU - This Menu\n
        VOTE - Vote in a poll\n
        
      EOS

      Twilio::SendMessage.call(@twilio_number, @recipient, message)
    end
  end
end