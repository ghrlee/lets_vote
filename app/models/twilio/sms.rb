module Twilio
  class Sms
    def self.call(params)
      self.new(params).call
    end

    def initialize(params)
      @params = params
    end

    def call
      case body.upcase.strip
      when 'MENU'
        Tell::Menu.call(twilio_number, recipient)
      when 'JOKE'
        Tell::Joke.call(twilio_number, recipient)
      when 'VOTE'
        Vote::Start.call(twilio_number, recipient)
      when 'EXIT'
        Vote::Exit.call(twilio_number, recipient)
      else
        Vote::Play.call(twilio_number, recipient, body)
      end
    end

    private

    def recipient
      @params['From']
    end

    def twilio_number
      @params['To']
    end

    def body
      @params['Body']
    end
  end
end