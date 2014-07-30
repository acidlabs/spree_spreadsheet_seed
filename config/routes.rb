Spree::Core::Engine.routes.draw do
  namespace :admin do
    #get "/import" => "home#seed"
    #post "/import" => "home#import"
    #post "/import_image" => "home#import_image"
    get '/import', to: redirect('/admin/import/new')
    resources :import, only: [:new, :create] 
    post '/import/image', to: 'import#image'
    
  end

end
