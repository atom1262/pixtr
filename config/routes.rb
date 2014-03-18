Pixtr::Application.routes.draw do
  get "/galleries/random" => "random_galleries#show"

  root "homes#show"
  resources :galleries do
    resources :images, only: [:new, :create]
  end

  resources :groups, only: [:index, :create, :new, :show]

  resources :images, except: [:index, :new, :create] do
  resources :comments, only: [:create]
  end
end