Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html
  post '/', to: 'reservations#index'

  # Defines the root path route ("/")
  # root "articles#index"
end
