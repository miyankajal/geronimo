require 'resque/server'
require 'resque_scheduler'
 
GeronimoSms::Application.routes.draw do
  
  resources :tag_comment_ideas

  resources :comments
  get '/comments/accept/:comment_id', to: 'comments#accept_comment', as: 'accept_comment'
  get '/comments/report/:idea_id/:comment_id', to: 'comments#report_comment', as: 'report_comment'

  resources :ideas
  get '/ideas/get_ideas/:portal_id/:class_id/:accepted/:tag_id', to: 'ideas#index', as: 'get_portal_ideas'
  get '/ideas/search_ideas/:portal_id/:class_id/:accepted/:tag_id', to: 'ideas#index', as: 'search_portal_ideas'
  get '/ideas/like/:idea_id', to: 'ideas#add_like', as: 'add_like'
  get '/ideas/accept/:idea_id', to: 'ideas#accept_idea', as: 'accept'
  get '/ideas/report/:idea_id', to: 'ideas#report_idea', as: 'report'
  get '/ideas/change_moderator/:idea_id/:moderator_id', to: 'ideas#change_moderator', as: 'change_moderator'
  get '/ideas/change_portal/:idea_id/:portal_id', to: 'ideas#change_portal', as: 'change_portal'
  
  get '/tag_comment_ideas/add_tag/:idea_id/:tag_id', to: 'tag_comment_ideas#add_tag', as: 'add_tag'
  
  get '/users/points_for_term/:term_id', to: 'users#points_for_term'
  get '/users/add_guardianship/:user_id/:guardian_id', to: 'users#add_guardianship', as: 'add_guardianship'
  get '/users/destroy_guardianship/:user_id/:guardian_id', to: 'users#destroy_guardianship', as: 'destroy_guardianship'
  

  resources :posting_portals

  resources :tags

  resources :schools

  get "password_resets/new"
  resources :guardianships

  resources :terms
  
  resources :password_resets

  root 'sessions#new'
  
  match '/about' => 'static_pages#about', via: [:get]
  match '/all_users' => 'static_pages#all_users', via: [:get]
  match '/settings' => 'static_pages#settings', via: [:get]
  match '/reports' => 'static_pages#reports', via: [:get]
  match '/user_report' => 'static_pages#user_report', via: [:get]
  
  match '/bulletin_board' => 'ideas#_bulletin_board', via: [:get]
  
  match '/contact_us' => 'static_pages#contact_us', via: [:get]
  match '/demo' => 'static_pages#demo', via: [:get]
  
  match '/signout' => 'sessions#destroy', via: [:delete]

  resources :class_sections

  resources :alerts

  resources :points

  resources :users
  match 'user/:type/:ward' => 'users#index', via: [:get]
  
  resources :users do
    collection { post :import }
  end
  
  resources :users do
	member do
		get 'download_sample'
	end
  end
  
  resources :users do
      member do
          get 'get_term/:term_id', :action => 'get_term', :as => 'get_term'
      end
  end
  
  resources :user_types
  
  resources :teacher_roles
  
  resources :sessions, only: [:new, :create, :destroy]
  
  match '/settings' => 'static_pages#settings', via: [:get]
  match '/geronimo_settings' => 'static_pages#geronimo_settings', via: [:get]
  
 
  
  resources :student_points
  
  resources :student_points do
	member do
		get 'value_of_point', only: [:new]
	end
  end
  
  resources :teacher_class_relationships
  
  resources :alert_settings
  
  
  mount Resque::Server.new, at: "/resque"
 
  mount Resque::Server, :at => "/resque"

  
  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  # root 'welcome#index'

  # Example of regular route:
  #   get 'products/:id' => 'catalog#view'

  # Example of named route that can be invoked with purchase_url(id: product.id)
  #   get 'products/:id/purchase' => 'catalog#purchase', as: :purchase

  # Example resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Example resource route with options:
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

  # Example resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Example resource route with more complex sub-resources:
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', on: :collection
  #     end
  #   end

  # Example resource route with concerns:
  #   concern :toggleable do
  #     post 'toggle'
  #   end
  #   resources :posts, concerns: :toggleable
  #   resources :photos, concerns: :toggleable

  # Example resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end
  
  get '*path' => redirect('/')
end