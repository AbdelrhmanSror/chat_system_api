class ApplicationsController < ApplicationController
    before_action :setup_application, only: [:get, :update]

    def getAll
        @applications = Application.all
        render :json => {
            :body => @applications.as_json(:except => [:id])
          }    end

    def get
        render :json => {
            :body => @application.as_json(:except => [:id])
          }    end

    def update  
        @application.update(name:params[:name])
        render :json => {
            :body => @application.as_json(:except => [:id])
          }        
    end

    def create
      @application=Application.new(name:params[:name],chats_count:0)
      @application.save
      render :json => {
        :body => @application.as_json(:except => [:id])
      }
    end

    private
    def setup_application
        @application = Application.find_by(password_reset_token:params[:password_reset_token])
    end
   
end
