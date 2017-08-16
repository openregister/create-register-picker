Rails.application.routes.draw do
  root 'home#index'

  post 'choose-field', to: 'home#choose_field'
  post 'generate-picker-files', to: 'home#generate_picker_files'

  get 'show-picker', to: 'home#show_picker'
  get 'download', to: 'home#download'
  get 'data-file.json', to: 'data_files#show', as: :data_file
end
