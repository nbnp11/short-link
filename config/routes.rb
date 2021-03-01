Rails.application.routes.draw do
  resources :urls, only: [:create, :show], param: :short_link do
    get :stats
  end
end
