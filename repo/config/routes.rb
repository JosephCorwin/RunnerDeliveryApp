Rails.application.routes.draw do



   #static controller routes
  root   'static#home'
  get    'about',   to: 'static#about'
  get    'faq',     to: 'static#faq'
  get    'contact', to: 'static#contact'
  post   'contact', to: 'static#contact2'

  #friendly user routes
  get    'signup',  to: 'users#new'
  post   'signup',  to: 'users#create'
  get    'me',      to: 'users#show', as: 'profile'

  get    'login',   to: 'sessions#new'
  post   'login',   to: 'sessions#create'
  delete 'logout',  to: 'sessions#destroy'

  #item routes
  #get    'stores/:id/new_item',           to: 'items#new'
  #post   'stores/:id/new_item/confirmed', to: 'items#create'

  #user control routes
  post   'users/:id/hire', to: 'users#hire'
  post   'users/:id/fire', to: 'users#fire'

  #order control routes
  get    'orders/assigned/',    to: 'orders#assigned'
  post   'orders/:id/progress', to: 'orders#progress'
  post   'orders/:id/finished', to: 'orders#finished'

  #RESTful resources
  resources :users, :orders
  resource  :users, :orders
  resources :account_activations, only: [:edit]
  resources :password_resets,     only: [:new, :create, :edit, :update]

  #nested resources
  resources :stores do
    resources :items, only: [:new, :create, :edit, :update]
  end
  resources :items, only: [:index, :show, :destroy]
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end