class Chat < ApplicationRecord
    has_many:messages ,dependent: :destroy
    belongs_to :Application ,foreign_key: "application_id", class_name: "Application"  

    
    validates :chat_number, numericality: { greater_than_or_equal_to: 1}, presence:true
    # unique message_number on the level of the chat
    validates_uniqueness_of :chat_number , scope: :application_id


end
