Rails.application.routes.draw do



  resources :groups do
    resources :posts do
      resources :replies
    end
  end

  resources :users
  resources :tags
  resources :dashboards, only: [:index]


  root 'groups#show', :id => 'community'
  get 'signin' => 'sessions#new'
  post 'postupload' => 'posts#upload_file'
  post 'replyupload' => 'replies#upload_file'
  get 'groupposts/:id', to: 'groups#groupposts', as: 'groupposts'
  resource :session

  controller :sessions do
    get 'login' => :new
    post 'login' => :create
    delete 'logout' => :destroy
  end
end
