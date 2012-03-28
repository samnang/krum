GroupsSharevision::Application.routes.draw do
  resources :groups, only: :show

  root :to => 'groups#index'
end
