Expertse::Application.routes.draw do
  resources :tags

  resources :friendships

  resources :experts

  root :to => "home#index"
end
