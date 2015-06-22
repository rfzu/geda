Rails.application.routes.draw do
  get '/' => 'orders#index'
  resources :orders 
end
