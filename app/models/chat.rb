class Chat < ApplicationRecord
    require 'redis'

    has_many:messages ,dependent: :destroy

    #Instead of counting the number of responses every time the application are displayed,
    #a counter cache keeps a separate chat counter which is stored in each application's database row. 
    #The counter updates whenever a response is added or removed.
    #This allows the application index to render with one database query,
    #without needing to join the responses in the query. To set it up, 
    #flip the switch in the belongs_to relation by setting the counter_cache option.
    belongs_to :Application ,counter_cache: true ,foreign_key: "application_id", class_name: "Application"  

    
    validates :chat_number, numericality: { greater_than_or_equal_to: 1}, presence:true

    # unique chat_number on the level of the chat
    # we already added a Uniqueness constraints in the database for both of chat_number and application_id
    # Rails' ActiveRecord validation, such as the one below, is not a database-level validation, 
    # It is an application-level validation and works well if there is no race condition
    # to ensure data integrity we use indexes in database

    #validates_uniqueness_of :chat_number , scope: :application_id
end
