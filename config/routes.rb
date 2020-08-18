Rails.application.routes.draw do
  devise_for :users
  root "posts#index"
  resources :users
  resources :posts do
    collection do
      get 'list'
    end
    resources :comments, only: [:create, :destroy]
    resources :likes, only: [:create, :destroy]
  end
  
  post '/homes/guest_sign_in', to: 'homes#new_guest'
end
