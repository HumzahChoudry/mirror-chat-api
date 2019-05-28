class Api::V1::ChatsController < ApplicationController

  def create
    #make new chat
    chat = Chat.create(title: params[:title], chat_type_id: params[:chat_type_id], admin_id: params[:admin_id])

    # add users to chat
    add_users
  end

  def show
     @chat = Chat.find(params[:id])
     render json: @chat
  end

  def send_message
   # find chat
   @chat = Chat.find(params[:chat_id])

   # create message
   @new_message = Message.create(content: params[:content], chat_id: params[:chat_id], user_id: params[:user_id])

   # send message over websocket
   ChatChannel.broadcast_to(@chat, {
     type: "NEW_MESSAGE",
     message: @new_message
     })
  end

  def add_users
    chat = params[:chat_id]
    params[:users].each do |user_id|
      UserChat.create(user_id: user_id, chat_id: chat.id)
      UserChannel.broadcast_to(@user, {
        type: "NEW_CHAT",
        chat: chat
        })
    end
  end
end
