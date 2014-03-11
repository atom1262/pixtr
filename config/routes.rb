Pixtr::Application.routes.draw do
  get "/galleries/random" => "random_galleries#show"

  root "galleries#index"
  # get "/" => "galleries#index" <-- same as above

  resources :galleries do
    resources :images
  end
  # get "/galleries/new" => "galleries#new"
  # get "/galleries/:id" => "galleries#show", as: :gallery
  # post "/galleries" => "galleries#create"
  # get "/galleries/:id/edit" => "galleries#edit"
  # patch "/galleries/:id" => "galleries#update"
  # delete "/galleries/:id" => "galleries#destroy"

  # the above will become resources :galleries
end
