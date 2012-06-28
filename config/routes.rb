VinsolApp::Application.routes.draw do

  resources :users, :except => [:destroy, :edit, :update] do
    member do
      get :following, :followers
    end
  end
    
  resources :microposts, only: [:create] do
    post :retweet, :on => :member
  end
  resources :relationships, only: [:create, :destroy]
       
  root :to => 'users#new'

end
