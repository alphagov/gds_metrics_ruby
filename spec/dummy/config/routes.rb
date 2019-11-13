Rails.application.routes.draw do
  get "/trigger-error", to: "error#error"
  get "foo/:bar" => "foo#bar"
end
