Rails.application.routes.draw do

  devise_for :users,skip: [:passwords], controllers: {
    registrations: "public/registrations",
    sessions: 'public/sessions'
  }

  scope module: :public do
    root to: "homes#top"
    get 'about' => 'homes#about', as: 'about'
    get 'users/confirm' => 'users#confirm', as: 'confirm'
    resources :users, only:[:show, :edit, :update, :destroy] do
      resource :relationships, only: [:create, :destroy]
      get :follows, on: :member
      get :followers, on: :member
    end
    get 'posts/rank' => 'posts#rank', as: 'rank'
    get 'posts/follows' => 'posts#follows', as: 'follows'
    resources :posts, only:[:index, :new, :create, :show, :destroy] do
      resource :favorites, only: [:create, :destroy]
      resources :post_comments, only:[:create, :destroy]
    end
  end

  devise_for :admin, skip: [:registrations, :passwords] ,controllers: {
    sessions: "admin/sessions"
  }

  namespace :admin do
    root to: "homes#top"
    resources :categories, only:[:index, :create, :edit, :update]
    resources :users, only:[:index, :show, :edit, :update, :destroy]
    resources :posts, only:[:show, :destroy] do
      resources :post_comments, only:[:destroy]
    end
  end

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
