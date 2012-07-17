Bikeroar::Application.routes.draw do
  namespace :api do
    resources :pages, :only => :index
  end
end
