Rails.application.routes.draw do
  root 'home#index'
  post 'choose-field', to: 'home#choose_field'
end
