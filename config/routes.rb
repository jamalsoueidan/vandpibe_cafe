# -*- encoding : utf-8 -*-
VandpibeCafe::Application.routes.draw do
  root :to => 'cities#index'
  
  ActiveAdmin.routes(self)

  match '/auth-js' => 'main#auth_js', :via => :get, :as => 'authjs'
  match '/sitemap.xml' => 'main#sitemap', :format => :xml
  match '/auth/:provider/callback' => 'main#auth'
  match '/logout' => 'main#logout', :via => :get, :as => 'logout'
  match '/login' => 'main#login', :via => :get, :as => 'login'
  match '/kontakt' => 'main#contact', :via => [:get, :post], :as => 'contact'

  match '/toplist' => "locations#toplist", :via => :get, :as => 'toplist'
  match '/toplist/:order' => "locations#toplist", :via => :get, :as => 'order_toplist'

  resources :comments, :only => [:create, :new, :destroy]
  resources :ratings, :only => [:create, :new]
  resources :users

  get 'koeb' => "store#index", :as => 'store'
  post 'koeb/add_to_cart' => "store#add_to_cart", :as => 'add_to_cart_store'
  get 'koeb/:id' => "store::products#show", :as => 'store_product'


  resources :locations, :only => [:create, :destroy] do
    collection do
      match 'random'
    end
    member do
      get 'new_comment'
    end
  end

  match '/get_json' => "main#get_json", :via => :get
  match '/debat' => "questions#index", :as => 'questions', :via => :get
  match '/debat' => "questions#create", :as => 'questions', :via => :post

  match '/debat/:id/update' => "questions#update",  :as => 'update_question', :via => :put
  match '/debat/:id/delete' => "questions#destroy", :as => 'delete_question', :via => :delete
  match '/debat/:id/edit' => "questions#edit", :as => 'edit_question', :via => :get

  match '/debat/ubesvaret' => "questions#unanswered", :as => 'unanswered_questions', :via => :get
  match '/debat/mest' => "questions#hot", :as => 'hot_questions', :via => :get
  match '/debat/seneste' => "questions#recent", :as => 'recent_questions', :via => :get
  match '/debat/opret' => "questions#new", :as => 'new_question', :via => :get

  match '/debat/:id/skriv_svar' => "questions#write_answer", :as => 'question_write_answer'
  match '/debat/:id/*title' => "questions#show", :as => 'question', :via => :get

  match '/by/:city' => 'cities#old_url', :via => :get

  match '/:name' => "cities#show", :as => 'city'
  match '/:city_name/:name' => "locations#show", :as => 'city_location'
  match '/:city_name/:name/skriv_anmeldelse' => "locations#write_review", :as => 'city_location_write_review'

  

  # See how all your routes lay out with "rake routes"
  # This is a legacy wild controller route that's not recommended for RESTful applications.
  # Note: This route will make all actions in every controller accessible via GET requests.
  # match ':controller(/:action(/:id))(.:format)'
end
