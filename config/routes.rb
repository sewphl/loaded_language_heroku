Rails.application.routes.draw do
  root 'welcome#index'
  get 'signup' => 'users#new'
  post 'signup' => 'users#create'
  get 'login'   => 'sessions#new'
  post 'login'   => 'sessions#create'
  delete 'logout'  => 'sessions#destroy'
  get '/words/new' => 'words#new'

  get "https://loaded-language.herokuapp.com/auth/google/callback" => 'sessions#create' ##/auth/google/callback
  get "https://loaded-language.herokuapp.com/auth/failure" => redirect('/')  ##, to:
  get "/users/user_with_most_words" => 'users#user_with_most_words'

  resources :users do
    resources :words, only: [:index, :new, :show]
  end
  resources :words, only: [:index, :show, :create, :edit, :update]
  resources :feelings, only: [:index, :show]

end
