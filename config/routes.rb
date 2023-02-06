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
  end

  scope module: :public do
    root to: 'homes#top'
    get 'about' => 'homes#about', as: 'about'
    get 'item/:id' => 'items#show', as: 'item'
    get 'items' => 'items#index', as: 'items'
  end
  namespace :admin do
    root to: 'homes#top'

    resources :items
    resources :customers
  end


end
