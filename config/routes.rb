Rails.application.routes.draw do
  get 'participants/new'
  get 'participants/join'

  resources :participants
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
