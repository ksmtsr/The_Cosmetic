Rails.application.routes.draw do
  devise_for :customers, skip: [:passwords], controllers: {
    registrations: "public/registrations",
    sessions: "public/sessions"
}


  devise_for :admin, skip: [:registrations, :passwords], controllers: {
    sessions: "admin/sessions"
  }

  devise_scope :customer do
    post "customers/guest_sign_in", to: "public/sessions#guest_sign_in"
    post "customers/sign_up", to: "public/registrations#create"
  end

  scope module: :public do
    root to: "homes#top"
    get "about" => "homes#about", as: "about"
    get "item/:id" => "items#show", as: "item"
    get "items" => "items#index", as: "items"
    get "comments/:id/edit" => "customers#comments", as: "comments_edit"
    get "comments" => "customers#comments", as: "comments"

    resources :items do
      resources :comments
    end


    delete "cart_item/destroy_all" => "cart_items#destroy_all"
    post "cart_items/confirm" => "cart_items#confirm", as: "cart_items_confirm"
    resources :cart_items

    get "customers/information/edit" => "customers#edit", as: "edit_customers"
    get "customers/unsubscribe" => "customers#unsubscribe", as: "customer_unsubscribe"
    patch "customers/update" => "customers#update", as: "customer_update"
    patch "customers/withdrawal" => "customers#withdrawal", as: "customer_withdrawal"
    resource :customers, only: [:show]

    post "orders/confirm" => "orders#confirm", as: "orders_confirm"
    get "orders/complete" => "orders#complete", as: "orders_complete"
    resources :orders
  end

  namespace :admin do
    root to: "homes#top"
    resources :customers
    get "comments" => "customers#comments", as: "customer_comments"
    resources :comments

    resources :orders do
    resources :order_details
  end

    resources :items
  end
end
