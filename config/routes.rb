Rails.application.routes.draw do
  root 'welcome#index'
  get 'signup' => 'users#new'
  post 'signup' => 'users#create'
  get 'login'   => 'sessions#new'
  post 'login'   => 'sessions#create'
  delete 'logout'  => 'sessions#destroy'
  get '/words/new' => 'words#new'

  get "auth/google/callback" => 'sessions#create'
  get "auth/failure" => redirect('/')  ##, to:

  resources :users do
    resources :words, only: [:index, :new, :show]
  end
  resources :words, only: [:index, :create, :edit, :update] ##:index, :show,
  resources :feelings, only: [:index, :show]

end
