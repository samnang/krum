GroupsSharevision::Application.routes.draw do
  root :to => 'groups#index'

  resources :groups, except: [:edit, :update] do
    collection do
      post :submit
    end
  end
end
