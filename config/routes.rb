Rails.application.routes.draw do
  root 'welcome#index'
  get 'signup' => 'users#new'
  post 'signup' => 'users#create'
  get 'login'   => 'sessions#new'
  post 'login'   => 'sessions#create'
  delete 'logout'  => 'sessions#destroy'
  get '/words/new' => 'words#new'



  resources :users do
    resources :words, only: [:new, :show]
  end
  resources :words, only: [:index, :show, :create, :edit, :update]
  resources :feelings, only: [:index, :show]
end
