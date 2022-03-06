Rails.application.routes.draw do
  resources :products
  root "products#index"
  # root to: redirect("/products")
end
