Rails.application.routes.draw do
  devise_for :users
  root to: "pages#home"
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
    resources :movies, only: [:show] do
      resources :poly_review_tests, only: [:create]
    end
    resources :tv_series, only: [:show] do
      resources :poly_review_tests, only: [:create]
    end
end
