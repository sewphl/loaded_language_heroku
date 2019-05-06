Rails.application.routes.draw do
  root 'welcome#index'
  #get 'sessions/new'
  get 'signup' => 'users#new'
  post 'signup' => 'users#create'
  get 'login'   => 'sessions#new'
  post 'login'   => 'sessions#create'
  delete 'logout'  => 'sessions#destroy'
  #get 'welcome/index' => 'welcome#index'


  resources :users do
    resources :words, only: [:new, :show]
  end
  resources :words, only: [:index, :create, :edit, :update]
  resources :feelings, only: [:index, :show]
end
