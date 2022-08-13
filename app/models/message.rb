class Message < ApplicationRecord
    include Elasticsearch::Model
    # ensures that Elasticsearch indexes are updated when a record is created or updated.
    include Elasticsearch::Model::Callbacks
    #Instead of counting the number of responses every time the chats are displayed,
    #a counter cache keeps a separate message counter which is stored in each chat's database row. 
    #The counter updates whenever a response is added or removed.
    #This allows the chat index to render with one database query,
    #without needing to join the responses in the query. To set it up, 
    #flip the switch in the belongs_to relation by setting the counter_cache option.
    belongs_to :Chat ,counter_cache: true ,foreign_key: "chat_id", class_name: "Chat"  
    validates :message_number, numericality: { greater_than_or_equal_to: 1}, presence:true
    # unique message_number on the level of the chat
    # we already added a Uniqueness constraints in the database for both of message_number and chat_id
    #validates_uniqueness_of :message_number ,scope: :chat_id

    index_name "chat"
    document_type "message"

    settings index: { number_of_shards: 1 } do
        mapping dynamic: false do
          indexes :body,type: :text, analyzer: 'english'
          indexes :chat_id
        end
    end

    def as_indexed_json(options = nil)
        self.as_json( only: [:chat_id, :body ] )
    end

    def self.search(chat_id,query)
        __elasticsearch__.search(
            {
                "query": {
                    "bool": {
                        "must": [
                            {
                                "match": {"body":"*#{query}*"}
                            }
                        ],
                        "filter": [
                            {
                                "term": {
                                    "chat_id": chat_id
                                }
                            }
                        ]
                    }
                }
            }
        )
      end

end
