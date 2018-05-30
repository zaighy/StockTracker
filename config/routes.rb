Rails.application.routes.draw do
  devise_for :users, controllers: { registrations: 'users/registrations' }
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root 'welcome#index'

  get 'portfolio', to: 'users#portfolio'

  #get  'search_stocks', to: 'stocks#search'
  post 'search_stocks', to: 'stocks#search'

  resources :user_stocks, only: [:create, :destroy]

end
