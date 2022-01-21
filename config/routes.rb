Rails.application.routes.draw do
  scope "(:locale)", locale: /en|vi/ do
    root "static_pages#home"
    get "static_pages/home"
    get "/cart", to: "static_pages#cart"
    get "/checkout", to: "static_pages#checkout"
    get "/shop", to: "static_pages#shop"
    get "/product", to: "static_pages#product"
  end
end
