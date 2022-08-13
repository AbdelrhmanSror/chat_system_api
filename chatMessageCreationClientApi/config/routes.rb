Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html
 
  post'/applications/:password_reset_token/chats', to: 'chats#create'

  post'/applications/:password_reset_token/chats/:chat_number/messages/:message', to: 'messages#create'
  




  # Defines the root path route ("/")
  # root "articles#index"
end
