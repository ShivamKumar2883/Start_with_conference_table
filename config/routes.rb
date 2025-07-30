Rails.application.routes.draw do
  
  
  resources :j_users do
    resources :profiles do
      resources :posts do 
        collection do
          get :feed
     end #this one for colllection
  end #this one for post
end #this one for profile
end #this one for j_users
 
    get 'posts/:id', to: 'posts#show' #for direct /posts/:id
    root 'j_users#index'
end
