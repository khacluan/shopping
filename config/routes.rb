Rails.application.routes.draw do
  root 'shoppings#index'
  devise_for :users, controllers: {
    omniauth_callbacks: "users/omniauth_callbacks",
  }

  resources :shoppings, only: [:index]
  resources :carts, only: [] do
    collection do
      post    :add_item
      delete  :remove_item
      post    :add_discount
      delete  :remove_discount
      get     :checkout
      post    :checkout_process
      get     :payment
      post    :payment_process
    end
  end
end
