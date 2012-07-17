Bikeroar::Application.routes.draw do
  namespace :api do
    resources :pages, :only => [:index, :create, :show, :update, :destroy]
  end
end
