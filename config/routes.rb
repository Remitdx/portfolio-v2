Rails.application.routes.draw do
  root to: 'pages#home'
  resources "games", only: [:index, :show, :new, :update] do
    get '/rules', to: 'games#rules'
  end
  resources "players", only: [:create]
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
