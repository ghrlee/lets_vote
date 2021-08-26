class AddReceivedVotesToPoll < ActiveRecord::Migration[6.1]
  def change
    add_column :polls, :received_votes, :string, array: true, default: []
  end
end
