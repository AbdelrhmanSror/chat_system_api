class Application < ApplicationRecord
  
  has_many:chats ,dependent: :destroy
  # Rails 5 has added has_secure_token method to generate a random alphanumeric token for a given column.
  # By default, Rails assumes that the attribute name is token.
  # We can provide a different name as a parameter to has_secure_token if the attribute name is not token.

  has_secure_token :password_reset_token

  #def my_attribute
  #  @chat_count ||= initialize_my_attribute
  #end


  #def retrieve_chat_count
   # key = "#{self.password_reset_token}"
    #redis = Redis.new(host: 'localhost', port: 6379, db: 1)
    #value=redis.get(key)
    #if value.nil?
      #value =self.chats.count +1
      #redis.setex(key, 1.hour, value)
    #else
     # value=value+1
      #redis.set(key,value)
    #end
    #value
  #end


end
