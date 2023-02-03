Rails.application.routes.draw do

  devise_for :customers,skip: [:passwords], controllers: {
  registrations: "public/registrations",
  sessions: 'public/sessions'
}


devise_for :admin, skip: [:registrations, :passwords] ,controllers: {
  sessions: "admin/sessions"
}


  scope module: :public do
    root to: 'homes#top'
    get 'about' => 'homes#about', as: 'about'
    get 'item/:id' => 'items#show', as: 'item'
    get 'items' => 'items#index', as: 'items'
  end
  namespace :admin do
    root to: 'homes#top'
    
    resources :items
  end


end
