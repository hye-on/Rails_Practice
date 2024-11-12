Rails.application.routes.draw do
  resources :posts
  resources :banned_words, path: 'banned-words' do
    collection do
      get 'ui-schema', to: 'banned_words#ui_schema'
      get 'ui-schema/list', to: 'banned_words#list_ui_schema'
      get 'index-json', to: 'banned_words#index_json'
    end
  end

  # Defines the root path route ("/")
  # root "articles#index"
end
