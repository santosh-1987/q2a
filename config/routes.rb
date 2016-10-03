Rails.application.routes.draw do
  resources :questions
  resources :tags
  devise_for :users, :controllers => { registrations: 'registrations' }
  root "questions#index"
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
