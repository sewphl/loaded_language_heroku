Rails.application.routes.draw do
  #get 'sessions/new'
  get    'login'   => 'sessions#new'
  post   'login'   => 'sessions#create'
  delete 'logout'  => 'sessions#destroy'
  get 'welcome/index' => 'welcome#index'
  root 'script#index'
  resources :users do
    resources :words, only: [:new, :show]
  end
  resources :words, only: [:index, :create, :edit, :update]
  resources :feelings, only: [:index, :show]
end
