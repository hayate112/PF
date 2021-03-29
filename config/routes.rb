Rails.application.routes.draw do
  devise_for :users, controllers: {
    sessions: 'users/sessions',
    registrations: 'users/registrations',
    passwords: 'users/passwords',
  }

  devise_for :admins, controllers: {
    sessions: 'admins/sessions',
    registrations: 'admins/registrations',
    passwords: 'admins/passwords',
  }
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root to: 'homes#top'
  get '/about' => 'homes#about'

  scope module: :users do
    resource :users, only: [:show] do
      collection do
        get 'unsubscribe'
        patch 'withdraw'
      end
    end
    resources :blogs, only: [:index, :show] do
      collection do
        get 'blog_history'
        get 'blog_search'
        get 'blog_genre_search'
      end
      resource :blog_likes, only: [:create, :destroy]
      resources :comments, only: [:create, :destroy]
    end
    resources :items, only: [:index, :show] do
      member do
        get 'review'
      end
      collection do
        get 'item_history'
        get 'item_search'
        get 'item_genre_search'
      end
      resources :reviews, only: [:create, :destroy]
    end
    resources :cart_items, except: [:new, :show, :edit] do
      collection do
        delete 'destroy_all'
      end
    end
    resources :receivers, except: [:new, :show]
    resources :orders, only: [:index, :show, :create] do
      collection do
        get 'information'
        post 'confirm'
        get 'complete'
      end
    end
    get 'searchs' => 'searchs#search'
  end

  namespace :admins do
    resources :users, only: [:index, :show]
    resources :blogs
    resources :genres, except: [:new, :show, :destroy]
    resources :items, except: [:destroy]
    resources :orders, only: [:index, :show, :update]
    get 'searchs' => 'searchs#search'
  end
end
