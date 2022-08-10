class MessagesController < ApplicationController
    before_action :setupApplicationAndChat, only: [:get, :update,:getAll,:create]
    before_action :setupMessage, only: [:get, :update]


    def getAll
        render :json => {
            :message => @chat.messages.as_json(:except => [:id])
          }
    end

    def create 
        @message=Message.new
        @message.body=params[:message]
        @message.chat_id=params[:chat_number]
        @message.save
        @chat.update(message_count:@chat.message_count+1)
        render(json: {"message number": @message.message_number}, status: :ok)

    end

    def get
        render :json => {
            :message => @message.as_json(:except => [:id])
          }
    end

    def update  
        @message.update(body:params[:message])
        render :json => { :message => @message.as_json(:except => [:id]) }
    end

    private
    def setupApplicationAndChat
        @application = Application.find_by(password_reset_token:params[:password_reset_token])
        if !@application.present?
             render(json: {message: "invalid token"}, status: :ok)
         end
        @chat=@application.chats.find_by(id:params[:chat_number])
        if !@chat.present?
            render(json: {chat: "chat not exist"}, status: :ok)
        end
    
      
    end
    private
    def setupMessage
        @message=@chat.messages.find_by(id:params[:message_number])
        if !@message.present?
            render(json: {chat: "message not exist"}, status: :ok)
        end
      
    end

end
