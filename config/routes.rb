Rails.application.routes.draw do
  

  root to: 'static_pages#index'
  resources :photos, :charges, :posts
  resources :photos do 
    resources :posts 
  end
  match 'about', to: 'static_pages#about', via: 'get'
  match 'contact', to: 'static_pages#contact', via: 'get'


  devise_for  :users,
              :path => '',
              :path_names => {  :sign_in =>       'login',
                                :sign_out =>      'logout',
                                :sign_up =>       '',
                                :registration =>  'register',
                                :edit =>          'edit',
                                :cancel =>        'cancel',
                                :confirmation =>  'verification'  },
              controllers: {omniauth_callbacks: 'omniauth_callbacks',  registrations: 'registrations'}

  devise_scope  :user  do 
    match '/user', to: 'registrations#show', via: 'get'
   # get '/profile', to: 'registrations#show', as: 'profile'
 end



end 