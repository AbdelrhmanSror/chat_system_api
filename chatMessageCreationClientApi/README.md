# Chat System Client API

Project repository implementing a Chat System Client API using Ruby On Rails that deals with creation of chats and messages using message queue.

## Features
- REST API exploring the main HTTP verbs and features
- Redis Cache in Memory
- Docker container.
- Message Queue : RabbitMQ

## Instructions

-  Note that the chat system API should be running for the entire operation, the client suppose that there are data in the chat system ,it is not designed to deal with cases of empty data it will drop an internal server error if anything happens, like creating a chat with an invalid token or creating a message with either invalid token or chat_number

## Operations

### Create chat for a specific application

`POST` `/applications/{password_reset_token}/chats`


```json
{
    "chat number": 1
}
```
### Create message in a certain chat within application

`POST` `/applications/{password_reset_token}/chats/{chat_number}/messages/{message}`


```json
{
    "message number": 1
}
```

## Description
the application starts with a request to either create a chat or messages, internally we utilize [Redis](https://redis.io/) Cache in-memory data store for boosting up performance and reducing the query to the database, by saving the chat_count and message_count in memory for an hour.
- during this hour if any request for creating chats or messages is made, we go for Redis and search for value, if it exists we return it as a response otherwise we  consume the original chat system API for getting the value, store it in Redis for later reference, and then return the response, 
- in the original chat system we made a boost up by aggregating and indexing these values using the counter cache, Instead of counting the number of responses every time the application is displayed, a counter cache keeps a separate chat counter which is stored in each application's database row. The counter updates whenever a response is added or removed. this allows the application index to render with one database query, without needing to join the responses in the query.
- messages queue is used for delivering a request to the chat system for creation, we use it for its durability and assurance of message delivery.
  [RabbitMQ](https://www.rabbitmq.com/) is being used as our message broker for this. This reduces the load on web app servers and their delivery times because it efficiently delegates resource-intense tasks to third parties with no other tasks. also, it assures that the messages will be delivered even in cases of servers being down, it will keep the messages, and deliver them when servers are up and running.
- also, we handled cases where race conditions might happen 
    - when a value does not exist in memory we go and fetch it from the chat system API during that we make a lock on the access key to prevent concurrent requests from modifying data at the same time, [RedLock](https://github.com/leandromoreira/redlock-rb) is used for this. 
   -  we  added a Uniqueness constraints in the database for cases when cocurent requests happens.
- to ensure data integrity we use indexes in database and to speed up querying certain value that are frequently access.
- we leveraged elastic search for full-text search of messages within chats 
