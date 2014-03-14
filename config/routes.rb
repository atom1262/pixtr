Pixtr::Application.routes.draw do
  get "/galleries/random" => "random_galleries#show"

  root "galleries#index"
  # get "/" => "galleries#index" <-- same as above
resources :users, only: [:new, :create]
resource :session, only: [:new, :create, :destroy]


  resources :galleries do
    resources :images
  end
end 