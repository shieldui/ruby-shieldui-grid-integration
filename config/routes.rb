Rails.application.routes.draw do
  root to: 'dashboard#default'
  resources :expenses
end
