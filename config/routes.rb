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
      end

      namespace :items do
        get '/most_revenue' => 'revenue#index'
        get '/most_items' => 'item#index'
        get '/:id/best_day' => 'item#show'
      end

      namespace :customers do
        get '/:id/favorite_merchant' => 'merchant#show'
      end

      resources :merchants, only: [:index, :show] do
        resources :items, only: [:index, :show]
        resources :invoices, only: [:index, :show]
      end
    end
  end

end
