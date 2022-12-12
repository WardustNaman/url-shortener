Rails.application.routes.draw do
  get 'url/index'
  get 'url/show'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

  root 'url#index'
  resources :url

  get '/stats', to: 'url#new'
  get '/:short_url', to: 'url#redirect_url'
end
