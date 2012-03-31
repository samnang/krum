GroupsSharevision::Application.routes.draw do
  root :to => 'groups#index'
  match "/images/uploads/*path" => "gridfs#serve"

  resources :groups
end
