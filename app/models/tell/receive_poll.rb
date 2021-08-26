module Tell
  class ReceivePoll
    def self.call(twilio_number, recipient, body)
      new(twilio_number, recipient, body).call
    end

    def initialize(twilio_number, recipient, body)
      @twilio_number = twilio_number
      @recipient = recipient
      @body = body
    end

    def call
      if poll
        calculate_results
      else
        Twilio::SendMessage.call(@twilio_number, @recipient, "Can't find your poll.")
      end
    end

    private

    def poll
      Poll.where("'#{@recipient.tr('+', '')}' = ANY(recipient_numbers)").last
    end

    def calculate_results
      poll.update_attribute(:received_votes, poll.received_votes << @body)
      if poll.received_votes.count >= poll.recipient_numbers.count
        binding.pry
        winning_option = find_winning_option(poll.received_votes)
        message = "Thanks for voting! The winner is \"#{poll.options[winning_option]}\""
        poll.recipient_numbers.each do |receiver|
          Twilio::SendMessage.call(@twilio_number, receiver, message)
          poll.destroy
        end
      else
        message = "Waiting for others to vote"
      end
    end

    def find_winning_option(options_array)
      options_array.max_by { |i| options_array.count(i) }.to_i - 1
    end
  end
end