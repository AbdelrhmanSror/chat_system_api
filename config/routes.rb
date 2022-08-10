Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html
  get '/applications', to: 'applications#getAll'
  get '/applications/:password_reset_token' ,to:'applications#get'
  post '/applications/:name', to: 'applications#create'
  put 'applications/:password_reset_token/:name' ,to:'applications#update'

  get '/applications/:password_reset_token/chats', to: 'chats#getAll'
  post'/applications/:password_reset_token/chats', to: 'chats#create'
  get '/applications/:password_reset_token/chats/:chat_number' ,to:'chats#get'


  post'/applications/:password_reset_token/chats/:chat_number/messages/:message', to: 'messages#create'
  get'/applications/:password_reset_token/chats/:chat_number/messages/', to: 'messages#getAll'
  get'/applications/:password_reset_token/chats/:chat_number/messages/:message_number', to: 'messages#get'
  put'/applications/:password_reset_token/chats/:chat_number/messages/:message_number/:message', to: 'messages#update'
  get'/applications/:password_reset_token/chats/:chat_number/messages/:message_number/search/:message', to: 'messages#search'







  # Defines the root path route ("/")
  # root "articles#index"
end
