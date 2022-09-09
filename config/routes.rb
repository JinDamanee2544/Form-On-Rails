Rails.application.routes.draw do
  root 'main#select'
  
  get 'main/select'
  get 'main/test' 
  get 'main/display'
  post 'main/validate'
  
  get 'score/list'
  get 'score/edit'
  post 'score/delete'
  post 'score/editHandler'
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
end
