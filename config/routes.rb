Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  root to: 'welcome#index'
  namespace :api do
    namespace :v1 do
      resources :products, only: %i[index show]
      namespace :users do
        scope ':user_id' do
          resources :products, except: %i[show]
        end
      end
    end
  end
end
