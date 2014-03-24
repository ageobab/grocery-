Grocery::Application.routes.draw do
  devise_for :users
  resources :users do
    resources :stores
  end
end
