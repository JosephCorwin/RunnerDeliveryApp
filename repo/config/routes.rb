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

  #employee control routes
  post   'users/:id/hire', to: 'users#hire'
  post   'users/:id/fire', to: 'users#fire'

  #order control routes
  get    'cart',                    to: 'orders#show'
  post   'cart/order',              to: 'orders#order_it'
  get    'orders/assigned/',        to: 'orders#assigned'
  post   'orders/:id/progress',     to: 'orders#progress'
  post   'orders/:id/finished',     to: 'orders#finished'
  patch  'cart_items/:id/delete',   to: 'cart_items#destroy'
  patch  'cart_items/:id/reduce',   to: 'cart_items#reduce'
  patch  'cart_items/:id/increase', to: 'cart_items#increase'  

  #RESTful resources
  resources :users
  resource  :users
  resources :orders,              only: [:index, :show, :edit, :create, :update, :destroy]
  resources :account_activations, only: [:edit]
  resources :password_resets,     only: [:new, :create, :edit, :update]
  resources :cart_items,          only: [:create, :edit, :update, :destroy]

  #nested resources
  resources :stores do
    resources :items, only: [:new, :create, :edit, :update]
  end
  resources :items, only: [:index, :show, :destroy]
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
