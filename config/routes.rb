Rails.application.routes.draw do
  
  resources :attendances do
     collection { post :add_today }
  end
  # resources :attendances
  
  devise_for :users
  match '/users/:id',     to: 'users#show',       via: 'get'
  resources :users #, :only =>[:index, :show, :edit, :destroy]
  
  root 'project#home'
  
  get 'project/home'
  get 'home' => 'project#home'
  get 'project/about'
  get 'about' => 'project#about'
  get 'project/contact'
  get 'contact' => 'project#contact'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
