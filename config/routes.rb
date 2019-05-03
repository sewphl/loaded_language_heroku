Rails.application.routes.draw do
  root 'welcome#index'
  resources :users do
    resources :words, only: [:new, :show]
  end
  resources :words, only: [:index, :create, :edit, :update]
  resources :feelings, only: [:index, :show]
end
