Rails.application.routes.draw do


  devise_for :customers,skip: [:passwords], controllers: {
    registrations: "public/registrations",
    sessions: 'public/sessions'
}


  devise_for :admin, skip: [:registrations, :passwords] ,controllers: {
    sessions: "admin/sessions"
  }

  devise_scope :customer do
    post 'customers/guest_sign_in', to: 'public/sessions#guest_sign_in'
    post 'customers/sign_up',to: 'public/registrations#create'
  end

  scope module: :public do
    root to: 'homes#top'
    get 'about' => 'homes#about', as: 'about'
    get 'item/:id' => 'items#show', as: 'item'
    get 'items' => 'items#index', as: 'items'
    resources :items

    get 'customers/information/edit' => 'customers#edit', as: 'edit_customers'
    get 'customers/unsubscribe' => 'customers#unsubscribe', as: 'customer_unsubscribe'
    patch 'customers/update' => 'customers#update', as: 'customer_update'
    patch 'customers/withdrawal' => 'customers#withdrawal', as: 'customer_withdrawal'
    resource :customers, only: [:show]
  end
  namespace :admin do
    root to: 'homes#top'

  end


end
