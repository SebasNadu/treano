Rails.application.routes.draw do
  devise_for :users, controllers: { registrations: 'users/registrations' }
  root to: "pages#home"
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
  resources :movies, only: %i[index show] do
    member do
      post 'toggle_favorite', to: "movies#toggle_favorite"
    end
    resources :list_items, only: %i[create]
    resources :reviews, only: %i[create]
  end

  resources :reviews, only: %i[edit update destroy]
  resources :list_items, only: %i[destroy]

  resources :tvs, only: %i[index show] do
    member do
      post 'toggle_favorite', to: "tvs#toggle_favorite"
    end
    resources :list_items, only: %i[create]
    resources :reviews, only: %i[create]
  end

  resources :lists do
    member do
      post 'toggle_favorite', to: "lists#toggle_favorite"
    end
  end

  resources :users do
    get '/dashboard', to: "pages#dashboard"
    get '/my_lists', to: "pages#my_lists"
  end


  get '/leaderboard', to: "pages#leaderboard"
  get '/search', to: "pages#search"

end
