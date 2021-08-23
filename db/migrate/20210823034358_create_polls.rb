class CreatePolls < ActiveRecord::Migration[6.1]
  def change
    create_table :polls do |t|
      t.string :question
      t.string :options, array: true, default: []
      t.string :recipient_numbers, array: true, default: []
      t.string :sender_number

      t.timestamps
    end
  end
end
