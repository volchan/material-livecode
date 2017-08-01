Rails.application.routes.draw do
  devise_for :users

  mount ActionCable.server => '/cable'

  root to: 'pages#home'

  mount Sidekiq::Web => '/sidekiq'

  get '/posts/refresh', to: 'posts#refresh'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
