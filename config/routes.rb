GroupsSharevision::Application.routes.draw do
  root :to => 'groups#index'

  resources :groups, except: [:edit, :update]

  match "/images/uploads/*path" => "gridfs#serve"
end
