Pixtr::Application.routes.draw do
  get "/galleries/random" => "random_galleries#show"

  get "tags/:tag", to: "images#index", as: :tags

  root "homes#show" 

  resource :dashboard, only: [:show]

  resources :galleries do
    member do
      post "like" => "like_galleries#create"
      delete "unlike" => "like_galleries#destroy"
    end
    resources :images, only: [:new, :create]
  end

  resources :groups, only: [:index, :create, :new, :show] do
    member do 
      post "join" => "group_memberships#create"
      delete "leave" => "group_memberships#destroy"
      post "like" => "like_groups#create"
      delete "unlike" => "like_groups#destroy"
    end 
  end

  resources :images, except: [:index, :new, :create] do
    member do
      post "like" => "like_images#create"
      delete "unlike" => "like_images#destroy"
    end 
    resources :comments, only: [:create]
  end

  resources :comments, only: [:destroy]

 # post "users/:id/follow" => "follwing_relationships#create", as: :follow_user <-- same as below

  resources :users, only: [:show] do
    member do
      post "follow" => "following_relationships#create"
      delete "unfollow" => "following_relationships#destroy"
    end
  end
end