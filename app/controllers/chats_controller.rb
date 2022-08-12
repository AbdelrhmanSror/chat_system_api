class ChatsController < ApplicationController
    before_action :setupApplication

    def create 
        @chat=Chat.new
        @chat.application_id=@application.id
        @chat.message_count=0
        @chat.save
        @application.update(chat_count:@application.chat_count+1)
        render(json: {"chat number": @chat.chat_number}, status: :ok)
    end

    def getAll
        render :json => {
            :chat => @application.chats.as_json(:except => [:id])
          }
    end 
    def get
        @chat=@application.chats.find_by(id:params[:chat_number])
        if @chat.present?
            render :json => {
                :chat => @chat.as_json(:except => [:id])
              }
        else
            render(json: {chat: "chat not exist"}, status: :bad_request)
        end
    end

    private
    def setupApplication
        @application = Application.find_by(password_reset_token:params[:password_reset_token])
        if !@application.present?
            render(json: {message: "invalid token"}, status: :unauthorized)
        end

    end

end
