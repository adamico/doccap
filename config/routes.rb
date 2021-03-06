Doccap::Application.routes.draw do
  get 'communications/show'

  get 'communications/index'

  devise_for :users

  as :user do
    get "login",  to: "devise/sessions#new",      as: "login"
    get "logout", to:  "devise/sessions#destroy", as: "logout"
  end

  resources :coordonnees, only: [:show, :index]

  get "destroy_fichier", to: "s3_direct_upload#destroy", as: "destroy_fichier"

  get "search", to: "private#search"
  get "biblio", to: "private#biblio"
  get "coord", to: "coordonnees#index"

  get "intranet", to: "private#index"

  resources :communications, only: [:show, :index]

  namespace :admin do
    resources :users do
      put 'approve', on: :member
    end
    get 'tags', to: 'communications#tags', as: 'communication_tags'
    resources :communications
    resources :coordonnees
    resources :categories
    resources :pages, except: [:show]
  end

  root to: "home#index"
  resources :pages, path: "", only: [:show]
  get "page_not_found", to: "pages#not_found"
  get "*id" => "pages#show"
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
end
