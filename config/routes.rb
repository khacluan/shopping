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
    end
  end
  resource :checkout, path: '/checkout/step', only: [] do
    collection do
      get     :delivery
      patch   :submit_delivery
      get     :payment
      patch   :submit_payment
      post    :success
    end
  end

  # API
  namespace :api do
    namespace :v1 do
      resources :units, only: [] do
        collection do
          get :districts_by_city
          get :wards_by_district
        end
      end
    end
  end
end
