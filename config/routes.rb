Expertse::Application.routes.draw do
  resources :experts

  root :to => "home#index"
end
