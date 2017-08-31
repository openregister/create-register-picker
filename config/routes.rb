Rails.application.routes.draw do
  root 'home#index'

  post 'choose-field', to: 'home#choose_field'
  post 'generate-component-files', to: 'home#generate_component_files'

  get 'show-component', to: 'home#show_component'
  get 'download', to: 'home#download'
  get 'download-zip', to: 'home#download_zip'
  get 'data-file.json', to: 'data_files#show', as: :data_file
end
