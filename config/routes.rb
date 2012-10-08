Spree::Core::Engine.routes.draw do
  resources :gift_cards do
    get :activate, :on => :member
  end
end
