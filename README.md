# README

This README would normally document whatever steps are necessary to get the
application up and running.

# API Documentation

### Requirements

* Supports group message (a chat room), supports direct messaging
  * This was accomplished using the same table. A direct message is simply a private chat with 2 people. I created chat_type to allow for private and public chat types. I didn't see a need for separate models.
* Implement a reasonably scalable fan-out communication pattern, must implement stream consumers
  * This was done in the send*message and add_user controller methods. Using ActionCable for rails I was able to create a publisher/subscriber model for both Users and Chats. Anytime a new chat is added for a user, it will send that chat info to the user and anytime a new message is sent it will send it to anyone subscribed to that chat. It is worth noting that the UserChannel responds with a \_chat* instance and the ChatChannel responds with a _message_. The Channel is called user and chat channel because those are the ids you use to subscribe.
* Must support signup and jwt auth
  * Implemented full auth with a token
* Should be able to explain how to integrate the service to a front end developer
  * See endpoints below
* Should be submitted by sending a link to a public git repository
  * Done

### Endpoints

* **POST** `/api/v1/users` - _creates a new user_
  * parameters
    * username - string
    * password - string
    * bio - string (optional)
  * returns user instance and jwt token
* **POST** `/api/v1/chats` - creates new chat
  * parameters
    * title - string
    * chat_type_id - integer (defaults to 1, public)
    * users - array of integers(user_ids)
    * admin_id - integer
* **GET** `/api/v1/chats/:id` - retrieves chat, uses ChatSerializer
* **POST** /api/v1/login - retrieves user, uses UserSerializer
  * parameters
    * username - string
    * password - string
  * returns user instance and jwt token
* **POST** `/api/v1/messages` - _creates new chat message_
  * parameters
    * content - string
    * user_id - integer
    * chat_id - integer
* **POST** `api/v1/userchats`- _adds user_ids to chat_
  * parameters
    * chat_id - integer
    * users - array of integers (user_ids)
* **MOUNT** `/api/v1/cable`
  * opens web socket connection

#### Websocket Channels

* UserChannel
  * Subscribe via user_id
  * updates anytime user is added to a chat
  * returns chat instance
* ChatChannel
  * subscribe via chat_id
  * updates anytime a message is sent to chat
  * returns message instance

### Thoughts on scale

* Made a serializer for user, this includes all user chats and messages.

  * As for now it works quickly but depending on how many chats/messages this program has we should think about just getting user and chat id/title rather than nesting messages. Then we can grab first N messages when chat becomes "active chat"

* Chat response includes all beginning info (title, users, messages), from there on out, it will get messages via action ActionCable.
  * Only sending the messages via action cable was an engineering decision, I thought about resending the updated chat serialization but that wouldn't scale well and is repetitive
  * Need to think about building a method for send_message that checks whether the user_id is in the chat or not
  * Added an admin_id for future admin type roles such as adding/removing users from a chat
* Didn't need a separate API or end point for direct messages because they're just a private chatroom with 2 people
