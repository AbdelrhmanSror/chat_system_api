class ApplicationsController < ApplicationController

    before_action :setup_application, only: [:get, :update]
    after_action  :renderJson , only: [:get, :update]


    def getAll
        @applications = Application.all
        render(json: {body:@applications}, status: :ok)
    end

    def get
    end

    def update  
        @application.update(name:params[:name])
        
    end

    def create
      @application=Application.new(name:params[:name],chat_count:0)
      @application.save
      render(json: {body:@application}, status: :ok)
    end

    private
    def renderJson
        render(json: {body:@application}, status: :ok)
    end

    private
    def setup_application
        @application = Application.find_by(password_reset_token:params[:password_reset_token])
    end
   
end
