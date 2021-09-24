Rails.application.routes.draw do
  get 'likes/create'
  get 'likes/destroy'
  devise_for :users, controllers: { registrations: 'registrations' }
  root 'pages#timeline'

  resources :users, only: [:index, :show] do
    member do
      get :following
      get :followers
    end
  end

  get 'tweeters', to: 'users#index'

  resources :relationships, only: %i[create destroy]

  get 'pages/timeline'

  resources :tweets, only: %i[create edit update destroy]
  resources :likes, only: %i[create destroy], param: 'likeable_id'
  resources :comments, only: %i[create destroy]
end
