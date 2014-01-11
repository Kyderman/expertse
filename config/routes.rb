Expertse::Application.routes.draw do
  resources :tags

  resources :friendships

  resources :experts

  root :to => "experts#index"
end
