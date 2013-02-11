Krum::Application.routes.draw do
  root :to => 'groups#index'
  match '/admin' => 'application#admin_sign_in'

  resources :groups do
    collection do
      post :submit
    end
  end
  resources :events, :only => :index
end
