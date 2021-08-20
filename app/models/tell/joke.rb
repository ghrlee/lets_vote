module Tell
  class Joke
    def self.call(twilio_number, recipient)
      new(twilio_number, recipient).call
    end

    def initialize(twilio_number, recipient)
      @twilio_number = twilio_number
      @recipient = recipient
    end

    def call
      Twilio::SendMessage.call(@twilio_number, @recipient, jokes.sample)
    end

    private

    def jokes
      [
        "Chuck Norris doesn’t read books. He stares them down until he gets the information he wants.",
        "Time waits for no man. Unless that man is Chuck Norris.",
        "The chief export of Chuck Norris is pain.",
        "Chuck Norris can dribble a bowling ball.",
        "Chuck Norris counted to infinity… twice.",
        "Chuck Norris can do a wheelie on a unicycle."
      ]
    end
  end
end