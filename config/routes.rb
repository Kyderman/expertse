Expertse::Application.routes.draw do
  resources :tags

  resources :friendships 
 

  resources :experts do
    member do
      get 'set_current_expert'
      get 'remove_current_expert'
    end
  end
  
  
  root :to => "experts#index"
end
