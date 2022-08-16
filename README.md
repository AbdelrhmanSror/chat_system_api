# Chat System

Project repository implementing a Chat System API using Ruby On Rails that commnuicate with different kind of services.

## Features
- REST API exploring the main HTTP verbs and features
- Redis Cache in Memory
- MySql relational Database
- Docker container.
- Message Queue : RabbitMQ
- Elastic Search
- Automatic model mapping

## Instructions

- [Chat System API](./README.md)    availble on url:  localhost:3000
- [Chat System Client API](chatMessageCreationClientApi/README.md)   availble on url:  localhost:3001

#### Running as Docker Containers
intially the project is setuped to run as docker containers.
you should have docker on you device.just run the docker compose file and whole application will run as docker containers.
- docker-compose -f docker-compose.yaml up

## Operations

### Create an application

`POST` `/application/{name}`
```json
{
    "body": {
        "name": "whatsapp",
        "password_reset_token": "DKiPyjsPYDqpex1wE7X64sCq",
        "created_at": "2022-08-15T00:55:35.162Z",
        "updated_at": "2022-08-15T00:55:35.162Z",
        "chats_count": 0
    }
}
```

### Retrieve an application

`GET` `/applications/{password_reset_token}`

```json
{
    "body": {
        "name": "whatsapp",
        "password_reset_token": "DKiPyjsPYDqpex1wE7X64sCq",
        "created_at": "2022-08-15T00:55:35.162Z",
        "updated_at": "2022-08-15T00:55:35.162Z",
        "chats_count": 0
    }
}
```

### Update an application name

`PUT` `applications/{password_reset_token}/{name}`

```json
{
    "body": {
        "name": "Signal",
        "password_reset_token": "DKiPyjsPYDqpex1wE7X64sCq",
        "created_at": "2022-08-15T00:55:35.162Z",
        "updated_at": "2022-08-15T01:00:55.185Z",
        "chats_count": 0
    }
}
```

### Get all applications

`GET` `/applications`


```json
{
    "body": [
        {
            "name": "whatsapp",
            "password_reset_token": "YTWzMmswqDZieKSRywaYURm6",
            "created_at": "2022-08-15T00:29:19.678Z",
            "updated_at": "2022-08-15T01:02:40.902Z",
            "chats_count": 0
        },
        {
            "name": "messanger",
            "password_reset_token": "TcG7o7Yq17VD52Bw2GuXbFFM",
            "created_at": "2022-08-15T00:53:30.092Z",
            "updated_at": "2022-08-15T01:03:39.985Z",
            "chats_count": 0
        },
        {
            "name": "Signal",
            "password_reset_token": "DKiPyjsPYDqpex1wE7X64sCq",
            "created_at": "2022-08-15T00:55:35.162Z",
            "updated_at": "2022-08-15T01:00:55.185Z",
            "chats_count": 0
        }
    ]
}
```

### Create chat for a specific application

`POST` `/applications/{password_reset_token}/chats`


```json
{
    "chat number": 1
}
```

### Get chat for a specific application

`GET` `/applications/{password_reset_token}/chats/{chat_number}`


```json
{
    "chat": {
        "messages_count": 0,
        "created_at": "2022-08-15T01:08:29.275Z",
        "updated_at": "2022-08-15T01:08:29.275Z",
        "chat_number": 1
    }
}
```
### Create message in a certain chat within application

`POST` `/applications/{password_reset_token}/chats/{chat_number}/messages/{message}`


```json
{
    "message number": 1
}
```
### Get a message in a certain chat within application

`GET` `/applications/{password_reset_token}/chats/{chat_number}/messages/{message_number}`

```json
{
    "message": {
        "body": "\"Good what about you!\"",
        "message_number": 2,
        "created_at": "2022-08-15T01:14:56.755Z",
        "updated_at": "2022-08-15T01:14:56.755Z"
    }
}
```

### Get a message in a certain chat within application

`GET` `/applications/{password_reset_token}/chats/{chat_number}/messages/{message_number}`

```json
{
    "message": {
        "body": "\"Good what about you!\"",
        "message_number": 2,
        "created_at": "2022-08-15T01:14:56.755Z",
        "updated_at": "2022-08-15T01:14:56.755Z"
    }
}
```
### Update a message in a certain chat within application

`PUT` `/applications/{password_reset_token}/chats/{chat_number}/messages/{message_number}/{message}`

### Get all messages in a certain chat within application

`GET` `/applications/{password_reset_token}/chats/{chat_number}/messages/`

```json
{
    "message": [
        {
            "body": "\"Hi guys whatsapp\"",
            "message_number": 1,
            "created_at": "2022-08-15T01:14:04.104Z",
            "updated_at": "2022-08-15T01:14:04.104Z"
        },
        {
            "body": "\"Good what about you!\"",
            "message_number": 2,
            "created_at": "2022-08-15T01:14:56.755Z",
            "updated_at": "2022-08-15T01:14:56.755Z"
        },
        {
            "body": "\"Fine\"",
            "message_number": 3,
            "created_at": "2022-08-15T01:15:13.559Z",
            "updated_at": "2022-08-15T01:15:13.559Z"
        },
        {
            "body": "I need help with a test ,any body could help",
            "message_number": 4,
            "created_at": "2022-08-15T01:16:37.497Z",
            "updated_at": "2022-08-15T01:16:37.497Z"
        },
        {
            "body": "\"i am busy right now but i am gonna be free within hour\"",
            "message_number": 5,
            "created_at": "2022-08-15T01:17:41.724Z",
            "updated_at": "2022-08-15T01:17:41.724Z"
        }
    ]
}
```
### Search within all messages in a certain chat within application

`GET` `/applications/{password_reset_token}/chats/{chat_number}/messages/search/{query}`

http://localhost:3000/applications/YTWzMmswqDZieKSRywaYURm6/chats/1/messages/search/"hi "

```json
{
    "messages": [
        {
            "_index": "chat",
            "_type": "message",
            "_id": "1",
            "_score": 1.7573471,
            "_source": {
                "body": "\"Hi guys whatsapp\"",
                "chat_id": 1
            }
        }
    ]
}
```
http://localhost:3000/applications/YTWzMmswqDZieKSRywaYURm6/chats/1/messages/search/" i will be"


```json
{
    "messages": [
        {
            "_index": "chat",
            "_type": "message",
            "_id": "5",
            "_score": 1.87692,
            "_source": {
                "body": "\"i am busy right now but i am gonna be free within hour\"",
                "chat_id": 1
            }
        },
        {
            "_index": "chat",
            "_type": "message",
            "_id": "4",
            "_score": 0.6999644,
            "_source": {
                "body": "I need help with a test ,any body could help",
                "chat_id": 1
            }
        }
    ]
}
```




