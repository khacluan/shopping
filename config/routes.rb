Rails.application.routes.draw do
  devise_for :users
  root 'shoppings#index'
  resources :shoppings, only: [:index]
  resources :carts, only: [] do
    collection do
      post    :add_item
      delete  :remove_item
      post    :add_discount
      delete  :remove_discount
    end
  end
end
