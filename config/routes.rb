Rails.application.routes.draw do
  devise_for :users
  root to: 'pages#home'
  resources :personalised_emails, only: [:new, :create]
end
