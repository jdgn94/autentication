Rails.application.routes.draw do
  devise_for :users
  resources :profiles
  resources :transactions
  resources :bank_accounts
  resources :currencies
  resources :bank_types
  root 'welcome#index'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
