module Tell
  class SendPoll
    attr_reader :recipients, :sender, :question, :options
    def self.call(twilio_number, poll)
      new(twilio_number, poll).call
    end

    def initialize(twilio_number, poll)
      @recipient = poll.recipient_numbers
      @sender = poll.sender_number
      @question = poll.question
      @options = poll.options
      @twilio_number = twilio_number
    end

    def call
      message = <<~EOS
        Hi! Your contact at #{sender} wants your opinion!
        #{question}
        #{options_text}
        Vote by sending a number
      EOS

      Twilio::SendMessage.call(@twilio_number, @recipient, message)
    end

    def options_text
      string = ""
      options.each_with_index{|thing, index| string += "#{index + 1} - #{thing}\n"}
      string
    end
  end
end