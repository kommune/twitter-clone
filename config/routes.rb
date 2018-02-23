Rails.application.routes.draw do
  devise_for :users

  root "users#index"

  resources :users do

    resources :tweets do
      post :like, on: :member
      delete :dislike, on: :member
      get :likelist, on: :collection
    end

    get :search, on: :collection
    post :follow, on: :collection
    post :unfollow, on: :collection
    get :following, on: :collection
    get :follower, on: :collection
    get :profile, on: :collection
    get :total_like, on: :collection

    resources :tweets, only: [:index, :show] do
      resources :replies, only: [:create, :destroy]
    end
  end

  resources :tweets

end
