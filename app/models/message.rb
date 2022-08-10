class Message < ApplicationRecord
    belongs_to :Chat ,foreign_key: "chat_id", class_name: "Chat"  

end
