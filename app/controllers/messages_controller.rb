class MessagesController < ApplicationController
    before_action :setupApplicationAndChat, only: [:get, :update,:getAll,:create,:search]
    before_action :setupMessage, only: [:get, :update]


    def getAll
        render :json => {
            :message => @chat.messages.as_json(:except => [:id , :chat_id])
          }
    end

    def create 
        @message=Message.new
        @message.body=params[:message]
        @message.chat_id= @chat.id
        @message.message_number=params[:message_number]
        @message.save
        if @message.save
            @chat.update(message_count:@chat.message_count+1)
            render(json: {"message number": @message.message_number}, status: :ok)
        else
            render(json: {chat: "invalid message number"}, status: :bad_request)
        end
      
    end

    def get
        render :json => {
            :message => @message.as_json(:except => [:id,:chat_id])
          }
    end

    def update  
        @message.update(body:params[:message])
        render :json => { :message => @message.as_json(:except => [:id,:chat_id]) }
    end

    def search
        unless params[:query].blank?
          @results = Message.search(@chat.id,params[:query])
        end
        render(json: {"messages": @results}, status: :ok)
      end
    
    private
    def setupApplicationAndChat
        @application = Application.find_by(password_reset_token:params[:password_reset_token])
        if !@application.present?
             render(json: {message: "invalid token"}, status: :unauthorized)
        end
        @chat=@application.chats.find_by(chat_number:params[:chat_number])
        if !@chat.present?
            render(json: {chat: "chat not exist"}, status: :bad_request)
        end
    
      
    end
    private
    def setupMessage
        @message=@chat.messages.find_by(message_number:params[:message_number])
        if !@message.present?
            render(json: {chat: "message not exist"}, status: :ok)
        end
      
    end

end
