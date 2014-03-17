Pixtr::Application.routes.draw do
  get "/galleries/random" => "random_galleries#show"

  root "homes#show"
  # get "/" => "galleries#index" <-- same as above


  resources :galleries do
    resources :images, shallow: true
  end
end 