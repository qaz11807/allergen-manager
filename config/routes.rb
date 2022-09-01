Rails.application.routes.draw do
  use_doorkeeper do
    skip_controllers :authorizations, :applications, :authorized_applications
  end

  namespace :api do
    namespace :v1 do
      namespace :user do
        post '/register', action: 'register'
      end

      resource :profile, controller: :profile, only: [:show, :update]

      resources :allergens, module: :allergens, controller: :base, expect: [:show] do
        collection do
          delete '/', action: 'bulk_destroy'
        end

        resources :medicines, only: [:index] do
          collection do
            post '/', action: 'add'
            delete '/', action: 'remove'
          end
        end
      end

      resources :medicines, module: :medicines, controller: :base, expect: [:show] do
        collection do
          delete '/', action: 'bulk_destroy'
          put '/image', action: 'update_image'
        end

        resources :allergens, only: [:index] do
          collection do
            post '/', action: 'add'
            delete '/', action: 'remove'
          end
        end
      end

      resources :contacts do
        collection do
          put '/orders', action: 'orders'
          delete '/', action: 'bulk'
        end
      end
    end
  end
end
