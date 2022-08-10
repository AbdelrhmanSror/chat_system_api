class Application < ApplicationRecord
  
  has_many:chats ,dependent: :destroy
  # Rails 5 has added has_secure_token method to generate a random alphanumeric token for a given column.
  # By default, Rails assumes that the attribute name is token.
  # We can provide a different name as a parameter to has_secure_token if the attribute name is not token.

  has_secure_token :password_reset_token

  #def my_attribute
  #  @chat_count ||= initialize_my_attribute
  #end

 

end
