Rails.application.routes.draw do
  root "meetings#index"
  resources :meetings do
    member do
      post :attend
      delete :unattend
    end
  end
  devise_for :users
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
