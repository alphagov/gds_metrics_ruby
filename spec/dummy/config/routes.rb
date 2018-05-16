Rails.application.routes.draw do
  get "/trigger-error", to: "error#error"
  get 'example/:id' => 'example#get'
  post 'example/:id' => 'example#post'
end
