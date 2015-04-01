Rails.application.routes.draw do


  mount Ckeditor::Engine => '/ckeditor'
  resources :groups do
    resources :posts do
      resources :replies
    end
  end

  resources :users
  resources :tags
  resources :dashboards, only: [:index]


  root 'groups#show', :id => 1
  get 'signin' => 'sessions#new'
  get 'groupposts/:id', to: 'groups#groupposts', as: 'groupposts'
  resource :session

  controller :sessions do
    get 'login' => :new
    post 'login' => :create
    delete 'logout' => :destroy
  end
end
