Bikeroar::Application.routes.draw do
  namespace :api do
    resources :pages, :only => [:index, :create, :show, :update, :destroy] do
      get :published, :on => :collection
    end
  end
end
