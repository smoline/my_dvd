Rails.application.routes.draw do
  devise_for :users

  devise_scope :user do
    get "/users/auth/facebook/callback" => "users/omniauth_callbacks#facebook"
    get "/users/auth/google/callback" => "users/omniauth_callbacks#google"
    get "/users/auth/linkedin/callback" => "users/omniauth_callbacks#linkedin"
    get "/users/auth/github/callback" => "users/omniauth_callbacks#github"
  end

  get 'pages/landing'

  root 'pages#landing'

  resources :dvds do
    post :get_barcode, on: :collection
  end

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
