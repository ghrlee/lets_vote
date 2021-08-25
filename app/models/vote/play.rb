module Vote
  class Play
    attr_reader :body

    def self.call(twilio_number, recipient, body)
      new(twilio_number, recipient, body).call
    end

    def initialize(twilio_number, recipient, body)
      @twilio_number = twilio_number
      @recipient = recipient
      @body = body
    end

    def call
      if sms
        build_poll
      else
        Twilio::SendMessage.call(@twilio_number, @recipient, "Invalid command. Send MENU for a list of commands")
      end
    end

    private

    def sms
      @sms ||= SmsConversation.find_by(twilio_number: @twilio_number, recipient: @recipient)
    end

    def poll
      @poll ||= Poll.find_by(sender_number: @recipient)
    end

    def build_poll
      if is_question?
        get_question
      elsif is_phone_number?
        get_phone_numbers
      else
        get_options
      end
    end

    def get_question
      if poll
        response = "You already have a question in progress."
      else
        Poll.create(question: body, sender_number: @recipient)
        response = "What are the options? Separate each with a comma"
      end
      Twilio::SendMessage.call(@twilio_number, @recipient, response)
    end

    def get_options
      if poll.options.any?
        response = "You already have options."
      else
        options = body.split(', ')
        poll.update(options: options)
        response = "Great! Enter in some numbers"
      end

      Twilio::SendMessage.call(@twilio_number, @recipient, response)
    end

    def get_phone_numbers
      if poll.recipient_numbers.any?
        response = "You already have a question with phone number in progress."
      elsif body.split.any?{|item| Phonelib.invalid?(item)}
        invalid_numbers = body.split.select{|item| Phonelib.invalid?(item)}.join(', ')
        response = "The numbers #{invalid_numbers} are not valid, please try again"
      else
        response = "Great! Sending your poll"
        numbers = body.split(', ')
        poll.update(recipient_numbers: numbers)

      end
      # new service
      Twilio::SendMessage.call(@twilio_number, @recipient, response)
    end

    def is_question?
      body.ends_with?('?')
    end
  
    def is_phone_number?
      body.split(',').any?{ |response_item| response_item.match(/^(\d)+$/) }
    end
  end
end