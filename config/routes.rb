Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  namespace :api do
    namespace :v1 do
      resources :users, only: %i[create]
      resources :chats, only: %i[create show]
      post '/login', to: 'auth#create'
      post "messages", to: 'chats#send_message'
      post "userchats", to: 'chats#add_users'
      mount ActionCable.server => '/cable'
    end
  end
end
