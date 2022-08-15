# Chat System Client API

Project repository implementing a Chat System Client API using Ruby On Rails that deals with creation of chats and messages using message queue.

## Features
- REST API exploring the main HTTP verbs and features
- Redis Cache in Memory
- Docker container.
- Message Queue : RabbitMQ

## Instructions

  Note that chat system api should be running for full operation.


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
