require 'sidekiq/web'
Rails.application.routes.draw do
  

  

  root to: 'static_pages#index'
  resources :video_uploads, only: [:new, :create]
  resources :photos, :charges, :posts, :locations, :videos, only: [:index, :new, :create, :show]
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

 authenticate :user do 
  mount Sidekiq::Web => '/sidekiq'
 end


# # config/routes.rb
# authenticate :user, lambda { |u| u.admin? } do
#   mount Sidekiq::Web => '/sidekiq'
# end



end 