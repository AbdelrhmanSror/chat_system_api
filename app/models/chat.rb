class Chat < ApplicationRecord
    has_many:messages ,dependent: :destroy
    belongs_to :Application ,foreign_key: "application_id", class_name: "Application"  
end
