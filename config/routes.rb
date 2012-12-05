VandpibeCafe::Application.routes.draw do
  ActiveAdmin.routes(self)

  match '/sitemap.xml' => 'main#sitemap', :format => :xml
  match '/auth/:provider/callback' => 'main#auth'
  match '/logaf' => 'main#logout', :via => :get, :as => 'logout'
  match '/login' => 'main#login', :via => :get, :as => 'login'
  match '/kontakt' => 'main#contact', :via => [:get, :post], :as => 'contact'
  
  resources :comments, :only => [:create, :new, :destroy]
  resources :ratings, :only => [:create, :new]
  resources :users
  
  resources :locations, :only => [:create, :destroy]

  match '/get_json' => "main#get_json", :via => :get
  match '/sp%C3%B8rgsm%C3%A5l' => "questions#index", :as => 'questions', :via => :get
  match '/sp%C3%B8rgsm%C3%A5l' => "questions#create", :as => 'questions', :via => :post

  match '/sp%C3%B8rgsm%C3%A5l/:id/update' => "questions#update",  :as => 'update_question', :via => :put
  match '/sp%C3%B8rgsm%C3%A5l/:id/delete' => "questions#destroy", :as => 'delete_question', :via => :delete
  match '/sp%C3%B8rgsm%C3%A5l/:id/edit' => "questions#edit", :as => 'edit_question', :via => :get
  
  match '/sp%C3%B8rgsm%C3%A5l/ubesvaret' => "questions#unanswered", :as => 'unanswered_questions', :via => :get
  match '/sp%C3%B8rgsm%C3%A5l/mest' => "questions#hot", :as => 'hot_questions', :via => :get
  match '/sp%C3%B8rgsm%C3%A5l/seneste' => "questions#recent", :as => 'recent_questions', :via => :get
  match '/sp%C3%B8rgsm%C3%A5l/opret' => "questions#new", :as => 'new_question', :via => :get

  match '/sp%C3%B8rgsm%C3%A5l/:id/*title' => "questions#show",    :as => 'question', :via => :get
  
  match '/:name' => "cities#show", :as => 'city'
  match '/:city_name/:name' => "locations#show", :as => 'city_location'
  
  root :to => 'main#index'

  # See how all your routes lay out with "rake routes"
  # This is a legacy wild controller route that's not recommended for RESTful applications.
  # Note: This route will make all actions in every controller accessible via GET requests.
  # match ':controller(/:action(/:id))(.:format)'
end
