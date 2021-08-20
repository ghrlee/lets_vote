class CreateSmsConversations < ActiveRecord::Migration[6.1]
  def change
    create_table :sms_conversations do |t|
      t.string :twilio_number
      t.string :recipient
      t.string :message

      t.timestamps
    end
  end
end
