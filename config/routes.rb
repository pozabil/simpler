Simpler.application.routes do
  get '/tests', 'tests#index'
  post '/tests', 'tests#create'
  get '/tests/:id', 'tests#show'

  get '/secret/money', 'money#index'
  post '/secret/money/:number', 'money#create'
  get '/secret/money/:number', 'money#show'
end
