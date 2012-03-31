GroupsSharevision::Application.routes.draw do
  root :to => 'groups#index'

  resources :groups, except: [:edit, :update]
end
