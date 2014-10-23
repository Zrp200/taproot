Rails.application.routes.draw do

  # ------------------------------------------ Devise

  devise_for :users, :skip => [:sessions, :registrations]
  devise_scope :user do
    get '/login' => 'devise/sessions#new', :as => :new_user_session
    post '/login' => 'devise/sessions#create', :as => :user_session
    get '/logout' => 'devise/sessions#destroy', :as => :destroy_user_session
  end

  # ------------------------------------------ JSON
  # 
  # If you plan to use any public json routes, it's good to nest them in their
  # own scope. We use a scope instead of a namespace because a controller action
  # can have routes to it in different formats, so namespacing is unecessary.
  # 
  # scope 'json' do
  #   'users' => 'users#index'
  # end
  # 

  # ------------------------------------------ CMS App

  resources :sites, :only => [:index, :show], :param => :slug do
    scope :module => 'sites' do
      resources :page_types, :param => :slug, :path => :t do
        scope :module => :page_types do
          resources :page_type_fields, :controller => :fields, :param => :slug, 
            :path => :f
          resources :page_type_field_groups, :controller => :groups, 
            :param => :slug, :path => :g
        end
      end
      resources :users
    end
  end

  # ------------------------------------------ Home Page

  root :to => 'sites#index'

end
