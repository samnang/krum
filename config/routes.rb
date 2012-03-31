GroupsSharevision::Application.routes.draw do
  root :to => 'groups#index'

  resources :groups, only: [:index, :new, :create]

  match "/images/uploads/*path" => "gridfs#serve"
end
