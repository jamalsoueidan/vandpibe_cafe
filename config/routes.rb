# -*- encoding : utf-8 -*-
VandpibeCafe::Application.routes.draw do
  root :to => 'cities#index'
  
  #ActiveAdmin.routes(self)

  get '/auth-js' => 'main#auth_js', :as => 'authjs'
  get '/sitemap.xml' => 'main#sitemap', :format => :xml
  get '/auth/:provider/callback' => 'main#auth'
  get '/logout' => 'main#logout', :as => 'logout'
  get '/login' => 'main#login', :as => 'login'
  match '/kontakt' => 'main#contact', :via => [:get, :post], :as => 'contact'

  get '/toplist' => "locations#toplist", :as => 'toplist'
  get '/toplist/:order' => "locations#toplist", :as => 'order_toplist'

  resources :comments, :only => [:create, :new, :destroy]
  resources :ratings, :only => [:create, :new]
  resources :users

  get 'koeb' => "store#index", :as => 'store'
  post 'koeb/add_to_cart' => "store#add_to_cart", :as => 'add_to_cart_store'
  post 'koeb/remove_to_cart' => "store#remove_from_cart", :as => 'remove_from_cart_store'
  post 'koeb/get_cart' => "store#get_cart", :as => 'get_cart_store'
  get 'koeb/checkout' => "store#checkout", :as => "checkout_store"
  get 'koeb/:id' => "store/products#show", :as => 'store_product'


  resources :locations, :only => [:create, :destroy] do
    collection do
      get 'random'
    end
    member do
      get 'new_comment'
    end
  end

  get '/get_json' => "main#get_json"
  
  resources :questions, :only => [:index, :create]
  get '/by/:city' => 'cities#old_url'

  get '/:name' => "cities#show", :as => 'city'
  get '/:city_name/:name' => "locations#show", :as => 'city_location'
  get '/:city_name/:name/skriv_anmeldelse' => "locations#write_review", :as => 'city_location_write_review'
end