module Tell
  class Launch
    def self.call(twilio_number, recipient)
      new(twilio_number, recipient).call
    end

    def initialize(twilio_number, recipient)
      @twilio_number = twilio_number
      @recipient = recipient
    end

    def call
      message = <<~EOS
        ⁣⬛️⬛️⬛️⬛️✨⬛️⬛️⬛\n️
        ⬛️⬛️⬛️⬛️⬛️⬛️🔴⬛️\n
        ✨⬛️⬛️⬛️⬛️↗️⬛️⬛\n️
        ⬛️⬛️⬛️⬛️↗️⬛️⬛️⬛\n️⁣
        ⬛️⬛️⬛️🚀⬛️⬛️⬛️⬛\n️
        ⬛️⬛️↗️⬛️⬛️⬛️⬛️⬛\n️
        ⬛️🌎⬛️⬛️⬛️⬛️✨⬛\n️
        ⬛️⬛️🌒⬛️⬛️⬛️⬛️⬛\n️
      EOS

      Twilio::SendMessage.call(@twilio_number, @recipient, message)
    end
  end
end