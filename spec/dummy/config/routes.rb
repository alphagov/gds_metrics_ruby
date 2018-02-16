Rails.application.routes.draw do
  get "/trigger-error", to: "error#error"
end
