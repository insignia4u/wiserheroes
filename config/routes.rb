Rails.application.routes.draw do
  root to: "home#index"
  
  resources :boxes

  resources :links do 
    resource :favorite, only: [:create, :destroy]
  end
  
  match 'auth/:provider/callback', to: 'sessions#create', via: [:get, :post]
  match 'auth/failure', to: redirect('/'), via: :get
  match 'signout', to: 'sessions#destroy', as: 'signout', via: :get
end
