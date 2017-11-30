Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  namespace :api do
    namespace :v1 do
      namespace :merchants do
        get '/most_revenue' => 'revenue#index'
        get '/most_items' => 'item#index'
        get '/:id/revenue' => 'revenue#show'
        get '/revenue' => 'invoice#index'
        get '/:id/favorite_customer' => 'customer#show'
        get '/find_all' => "search#index"
        get '/find' => "search#show"
        get '/:id/invoices' => "invoice_relationship#show"
        get '/:id/items' => "item_relationship#show"

      end

      namespace :items do
        get '/most_revenue' => 'revenue#index'
        get '/most_items' => 'item#index'
        get '/:id/best_day' => 'item#show'
        get '/:id/invoice_items' => 'invoice_items#show'
        get '/:id/merchant' => 'merchant#show' 
        get '/find_all' => 'search#index'
        get '/find' => 'search#show'
      end

      namespace :customers do
        get '/:id/favorite_merchant' => 'merchant#show'
        get '/:id/invoices' => 'invoices#show'
        get '/:id/transactions' => 'transactions#show'
        get '/find_all' => "search#index"
        get '/find' => 'search#show'
      end

      namespace :invoices do
        get '/:id/transactions' => "transactions#show"
        get '/:id/invoice_items' => "invoice_items#show"
        get '/:id/items' => "items#show"
        get '/:id/customer' => "customer#show"
        get '/:id/merchant' => "merchant#show"
        get '/find_all' => 'search#index'
        get '/find' => 'search#show'
      end

      namespace :invoice_items do
        get '/:id/invoice' => "invoice#show"
        get '/:id/item' => "item#show"
        get '/find_all' => 'search#index'
        get '/find' => 'search#show'
      end

      namespace :transactions do
        get '/:id/invoice' => "invoice#show" 
        get '/find_all' => 'search#index'
        get '/find' => 'search#show'
      end

      resources :merchants, only: [:index, :show] do
        resources :items, only: [:index, :show]
        resources :invoices, only: [:index, :show]
      end
      resources :invoices, only: [:index, :show] do
        resources :transactions 
      end
      resources :customers, only: [:index, :show]
      resources :invoice_items, only: [:index, :show]
      resources :items, only: [:index, :show]
      resources :transactions, only: [:index, :show]
    end
  end

end
