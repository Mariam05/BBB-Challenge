Rails.application.routes.draw do
  root 'recordings#index'

  get 'recordings/index'
  get 'recordings/show'
  get 'recordings/new'
  get 'recordings/create'
  get 'recordings/delete'
  get 'recordings/destroy'
  get 'participants/new'
  get 'participants/join'

  resources :participants

  resources :recordings
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
