module Vote
  class Play
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
        # if we have vote in progress 
          # and if we get a question
            # if we already have a question, this is invalid
          # or if we get a set of options
            # make sure we have a question
          # or if we have a set of numbers
            # make sure we have a question and options
          # send question and options out to the set of numbers
          # 

          # if receiving a vote
          # check that vote answer is in the vote array (vote <= options.length?)
          # make sure voter only casts one vote??
          # if last vote, destroy the session
          # binding.pry
            # save message as question?
            # save new vote with message as question and @recipient as vote_sender


          build_poll

        # response = Vote::Choice.call(recipient, body)
      else
        Twilio::SendMessage.call(@twilio_number, @recipient, "Invalid command. Send MENU for a list of commands")
      end
    end

    private

    def sms
      @sms ||= SmsConversation.find_by(twilio_number: @twilio_number, recipient: @recipient)
    end

    def poll
      @poll ||= Poll.find_by(sender_number: @twilio_number)
    end

    def build_poll
      if @body.ends_with?('?')
        if poll && poll.question
          response = "You already have a question in progress. Enter in a few options."
        else
          Poll.create(question: @body, sender_number: @recipient)
          response = "What are the options?"
        end

        Twilio::SendMessage.call(@twilio_number, @recipient, response)

      end
    end
  end
end