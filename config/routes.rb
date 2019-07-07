Rails.application.routes.draw do

  namespace 'api' do
    namespace 'v1' do
      post '/areas', to: 'api#areas'
      post '/contains/:id', to: 'api#contains'
    end
    namespace 'v2' do
      post '/areas', to: 'api#areas'
      post '/contains/:id', to: 'api#contains'
    end

    namespace 'v3' do
      post '/areas', to: 'api#areas'
      post '/locations', to: 'api#locations'
      get '/contains/:area_id/:id', to: 'api#contains'
    end
  end

  post '*path', :to => 'application#routing_error'
  get '*path', :to => 'application#routing_error'
end
