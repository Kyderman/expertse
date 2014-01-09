Expertse::Application.routes.draw do
  resources :friendships

  resources :experts

  root :to => "home#index"
end
