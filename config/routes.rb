Bikeroar::Application.routes.draw do
  namespace :api do
    resources :pages, :only => [:index, :create, :show, :update, :destroy] do
      get :published, :on => :collection
      get :unpublished, :on => :collection
      post :publish, :on => :member
    end
  end
end
