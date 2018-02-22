Rails.application.routes.draw do
  devise_for :users

  root "users#index"

  resources :users do

    resources :tweets do
      post :like, on: :member
      delete :dislike, on: :member
    end

    get :search, on: :collection
    post :follow, on: :collection
    post :unfollow, on: :collection
    get :following, on: :collection
    get :follower, on: :collection

  end

  resources :tweets

end
