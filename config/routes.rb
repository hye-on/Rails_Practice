Rails.application.routes.draw do
  resources :posts
  resources :banned_words, path: 'banned-words' do
    collection do
      get 'ui-schema'
    end
  end

  # Defines the root path route ("/")
  # root "articles#index"
end
