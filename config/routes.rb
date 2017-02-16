Rails.application.routes.draw do
  devise_for :users,
    controllers: { omniauth_callbacks: 'users/omniauth_callbacks' }

  root to: 'places#index'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  resources :places do
    resources :reservations, only: [ :create ]
    resources :reviews, only:[ :create ]
  end
  resources :users, only: [:show]
  patch "reservations/:id/accept", to: "reservations#accept", as: :reservation_accept
  patch "reservations/:id/decline", to: "reservations#decline", as: :reservation_decline
end
