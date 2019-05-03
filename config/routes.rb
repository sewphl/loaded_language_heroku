Rails.application.routes.draw do
  map.root :controller => 'welcome', :action => :index
  resources :users do
    resources :words, only: [:new, :show]
  end
  resources :words, only: [:index, :create, :edit, :update]
  resources :feelings, only: [:index, :show]
end
