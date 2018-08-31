Rails.application.routes.draw do
  post 'authorize' => 'user_token#create'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  resource :users, only: [:show,:create,:destroy,:update]

  # deposit endpoints
  get 'deposits', to: 'deposits#index'
  post 'deposits', to: 'deposits#create'

  # transfer endpoints
  post 'transfers', to: 'transfers#create'
  get 'transfers', to: 'transfers#index'
end
