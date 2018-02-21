Rails.application.routes.draw do
  devise_for :users

  root "users#index"

  resources :tweets

  resources :users do
    get :search, on: :collection
    post :follow, on: :collection
  end
  
end
