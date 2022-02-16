Rails.application.routes.draw do

  devise_for :customers,skip: [:passwords], controllers: {
    registrations: "public/registrations",
    sessions: 'public/sessions'
  }

  devise_for :admin,skip: [:registrations, :passwords], controllers: {
    sessions: "adomin/sessions"
  }

  root to: "homes#top"
  get '/about' => 'homes#about'
  resources :items, only: [:index, :show]

  namespace :public do
    root to: 'homes#top'
    resources :cart_items, only: [:index, :update, :destroy, :create]
    resources :orders, only: [:new, :create, :index, :show]
    resources :addresses, only: [:index, :edit, :create, :update, :destroy]

    get '/customers/my_page' => 'customers#show'
    get '/customers/edit' =>'customers#edit'
    patch '/customers' => 'customers#update'
    get '/customers/hide' => 'customers#hide'
    patch '/customers/withdrawal' => 'customers#withdrawal'
    delete '/cart_items/destroy_all' => 'cart_items#destroy_all'
    post '/oders/confirm' => 'orders#confirm'
    get 'orders/complete' =>'orders#complete'
  end

  namespace :admin do
    root to: 'homes#top'
  end
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
