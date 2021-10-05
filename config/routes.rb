Rails.application.routes.draw do
  get 'documentos/index'
  get 'documentos/show'
  get 'documentos/edit'
  get 'documentos/new'

  get 'documentos/download/:id/:nome', to: 'documentos#download', as:'documento_download'
  get 'documentos/:id/destroy', to: "documentos#destroy", as: "documento_delete"

  post 'documentos/create'

  get 'pessoas/index'



  get 'client/index'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
