Rails.application.routes.draw do
  resources :orders
  resources :line_items
  resources :carts
  get 'store/index'
  resources :products

  root 'store#index'
end
