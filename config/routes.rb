Rails.application.routes.draw do
  post '/buy', to: 'buy#sale'
  get '/salesbyUser', to: 'buy#salesbyUser'
end
