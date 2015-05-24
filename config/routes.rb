Rails.application.routes.draw do
  devise_for :users
  resources :posts do
  	collection do
  		get :recent
  		get :active
  		get :unanswered
  	end
  	resources :comments
  end

  root 'posts#index'
end
