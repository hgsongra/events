Rails.application.routes.draw do
  root "meetings#index"
  resources :meetings
  devise_for :users
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
