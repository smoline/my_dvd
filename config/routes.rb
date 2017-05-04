Rails.application.routes.draw do
  devise_for :users, controllers: { omniauth_callbacks: 'omniauth_callbacks' }

  get 'pages/landing'

  devise_scope :user do
    root 'pages#landing'
  end

  resources :dvds

end
