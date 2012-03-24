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
  
  # The priority is based upon order of creation:
  # first created -> highest priority.

  # Sample of regular route:
  #   match 'products/:id' => 'catalog#view'
  # Keep in mind you can assign values other than :controller and :action

  # Sample of named route:
  #   match 'products/:id/purchase' => 'catalog#purchase', :as => :purchase
  # This route can be invoked with purchase_url(:id => product.id)

  # Sample resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Sample resource route with options:
  #   resources :products do
  #     member do
  #       get 'short'
  #       post 'toggle'
  #     end
  #
  #     collection do
  #       get 'sold'
  #     end
  #   end

  # Sample resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Sample resource route with more complex sub-resources
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', :on => :collection
  #     end
  #   end

  # Sample resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end


  # See how all your routes lay out with "rake routes"

  # This is a legacy wild controller route that's not recommended for RESTful applications.
  # Note: This route will make all actions in every controller accessible via GET requests.
  # match ':controller(/:action(/:id(.:format)))'
end
