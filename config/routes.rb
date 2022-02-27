Rails.application.routes.draw do

  devise_for :customers,path: "",skip: [:passwords], controllers: {
    registrations: "public/registrations",
    sessions: 'public/sessions'
  }

  devise_for :admin,skip: [:registrations, :passwords], controllers: {
    sessions: "admin/sessions"
  }

  root to: "homes#top"
  get '/about' => 'homes#about'
  get "/customers/:name/hide" => "homes#hide", as: "confirm_hide"
  patch "/customers/:name/withdraw" => "homes#withdraw", as: "withdraw_customers"

    scope module: "public" do
      resources :items, only: [:index, :show]
      resources :cart_items, only: [:index, :update, :destroy, :create]
      resources :orders, only: [:new, :create, :index, :show]
      resources :addresses, only: [:index, :edit, :create, :update, :destroy]
      get '/customers/my_page' => 'customers#show', as: :my_page
      get '/customers/edit' => 'customers#edit'
      patch '/customers' => 'customers#update'
      get '/customers/hide' => 'customers#hide'
      patch '/customers/withdrawal' => 'customers#withdrawal'
      delete '/cart_items/destroy_all' => 'cart_items#destroy_all'
      post '/oders/confirm' => 'orders#confirm'
      get 'orders/complete' =>'orders#complete'
      end


  namespace :admin do
    root to: 'homes#top'
    resources :items, only: [:index, :new, :create, :show, :edit, :update]
    resources :genres, only: [:index, :create, :edit, :update]
    resources :customers, only: [:index, :show, :edit, :update]
    resources :orders, only: [:show, :update]
    resources :order_history_details, only: [:update]
  end

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

end