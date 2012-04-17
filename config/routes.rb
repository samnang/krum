GroupsSharevision::Application.routes.draw do
  root :to => 'groups#index'
  match '/admin' => 'application#admin_sign_in'

  resources :groups, except: [:edit, :update] do
    collection do
      post :submit
    end
  end
end
