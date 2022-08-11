class Message < ApplicationRecord
    include Elasticsearch::Model
    # ensures that Elasticsearch indexes are updated when a record is created or updated.
    include Elasticsearch::Model::Callbacks
    belongs_to :Chat ,foreign_key: "chat_id", class_name: "Chat"  

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
