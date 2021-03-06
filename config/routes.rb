Rails.application.routes.draw do
  root 'welcome#index'
  get 'signup' => 'users#new'
  post 'signup' => 'users#create'
  get 'login'   => 'sessions#new'
  post 'login'   => 'sessions#create'
  delete 'logout'  => 'sessions#destroy'
  get '/words/new' => 'words#new'

  get "/auth/google/callback" => 'sessions#create'
  get "/auth/failure" => redirect('/')  ##, to:
  get "/users/user_with_most_words" => 'users#user_with_most_words'

  resources :users do
    resources :words, only: [:index, :new, :create, :show]
  end
  resources :words do
    resources :word_feelings, only: [:new, :create]
  end
  resources :words, only: [:index, :show]
  resources :feelings, only: [:index, :show]

end
