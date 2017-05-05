Rails.application.routes.draw do
  devise_for :users, controllers: { omniauth_callbacks: 'omniauth_callbacks' }

  get 'pages/landing'
  root 'pages#landing'
  resources :dvds

end
