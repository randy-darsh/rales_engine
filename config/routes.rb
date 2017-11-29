Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  namespace :api do
    namespace :v1 do
      namespace :merchants do
        get '/most_revenue' => 'revenue#index'
        get '/most_items' => 'item#index'
      end

      resources :merchants, only: [:index, :show] do
        resources :items, only: [:index, :show]
        resources :invoices, only: [:index, :show]
      end
    end
  end
  
end