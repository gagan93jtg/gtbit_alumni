Rails.application.routes.draw do

  root 'welcome#index'
  devise_for :users

  put 'user/password' => 'user#update_password', as: 'user_update_password'
  put 'user/preferences' => 'user#update_preferences', as: 'update_user_preferences'
  get 'user/preferences' => 'user#preferences', as: 'user_preferences'
  get 'posts/edit_history' => 'question_posts#edit_history'
  get 'posts/mark_answered/:id' => 'question_posts#mark_answered', as: 'mark_answered'

  get 'errors/file_not_found', as: 'error_file_not_found'
  get 'errors/unprocessable', as: 'error_unprocessable'
  get 'errors/internal_server_error', as: 'error_internal_server_error'

  post 'contact_us',      :to => 'welcome#contact_us_mail'
  post 'request_account', :to => 'welcome#request_account'
  post 'report_bug',      :to => 'welcome#report_bug'
  get  'team',            :to => 'welcome#team'

  # get  'user/:id/crop', :to => 'user#crop'
  # post 'user/:id/crop', :to => 'user#save_crop'

  resources :notifications, only: [:index]
  resources :posts, controller: 'question_posts'
  resources :job, controller: 'job_posts'
  resources :experience, controller: 'experience_posts'
  resources :faqs, only: [:index, :show]
  resources :user
  resources :comments, only: [:create]

  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with 'rake routes'.

  # You can have the root of your site routed with 'root'
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
end
