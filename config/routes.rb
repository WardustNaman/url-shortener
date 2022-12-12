Rails.application.routes.draw do
  get 'urls/index'
  get 'urls/show'
  post 'urls/index'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

  root 'urls#index'
  resources :urls

  get '/stats', to: 'urls#new'
  get '/:short_url', to: 'urls#redirect_url'
end
