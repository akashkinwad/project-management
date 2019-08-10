Rails.application.routes.draw do
  devise_for :users
  devise_scope :user do
    root to: "devise/sessions#new"
  end
  resources :users
  resources :dashboards, only: :index
  resources :todos, only: [:edit, :update]
  resources :projects do
    collection do
      get :details
    end
    resources :todos
  end
end
