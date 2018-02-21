Rails.application.routes.draw do
  devise_for :users

  root "users#index"

  resources :users do
    resources :tweets do
      post :like, on: :member
      delete :dislike, on: :member
    end
  end

  resources :tweets

  resources :users do
    get :search, on: :collection
    post :follow, on: :collection
  end
  
end
