Rails.application.routes.draw do
  root 'home#index'
  post 'choose-field', to: 'home#choose_field'
  post 'show-picker', to: 'home#show_picker'
  get 'download', to: 'home#download'
end
