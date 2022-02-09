Rails.application.routes.draw do
  scope "(:locale)", locale: /en|vi/ do
    root "static_pages#home"
    get "static_pages/home"
    get "/cart", to: "static_pages#cart"
    post "/cart", to: "static_pages#cart"
    get "/checkout", to: "static_pages#checkout"
    get "/shop", to: "static_pages#shop"
    get "/signup", to: "users#new"
    get "/login", to: "sessions#new"
    post "/login", to: "sessions#create"
    delete "/logout", to: "sessions#destroy"
    put "/carts/minus-qty-cart", to: "carts#minus", as: :minus_qty_cart
    put "/carts/plus-qty-cart", to: "carts#plus", as: :plus_qty_cart
    delete "/carts", to: "carts#destroy", as: :delete_cart
    resources :users
    resources :account_activations, only: :edit
    resources :password_resets, except: %i(index show destroy)
    resources :carts, only: :create
    resources :products, only: %i(index show)
    resources :comments, only: %i(create destroy)
    resources :rates, only: %i(create destroy)
  end
end
