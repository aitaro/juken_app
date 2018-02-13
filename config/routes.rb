Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  get 'search' => 'juken#search'
  post 'states' => 'juken#result'
  get 'result' => 'juken#result'
  get 'states' => 'juken#result'
end
