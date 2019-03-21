Rails.application.routes.draw do
  devise_for :users
  mount ShoppingCart::Engine => '/shopping_cart'
  root 'books#show'
  resources :books, only: %i[show]
  resources :customer, only: %i[index]
end
