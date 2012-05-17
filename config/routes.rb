FiveCBookExchange::Application.routes.draw do

  match "/auth/:provider/callback" => "sessions#create"
  match "/auth/failure" => "pages#home"
  match "/signout" => "sessions#destroy", :as => :signout


  get "requests/new"

  get "requests/create"

  get "requests/destroy"

  get "transactions/request_book"
  get "transactions/cancel_request"
  get "transactions/sold"

  match 'contact' => 'contact#new', :as => 'contact', :via => :get
  match 'contact' => 'contact#create', :as => 'contact', :via => :post
  match '/home' => 'pages#home'
  match '/about' => 'pages#about'

  match '/search', :to => 'listings#index'
  match '/delete_requests', :to => 'requests#destroy'
  resources :transactions, :only => [:show]
  resources :requests, :only => [:new, :create, :destroy]
  resources :users
  resources :listings do
    get :autocomplete_book_title, :on => :collection
    get :autocomplete_course_prof, :on => :collection
  end
  root :to => 'pages#home'
  
end
