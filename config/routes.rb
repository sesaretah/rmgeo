Rails.application.routes.draw do


  namespace 'api' do
    namespace 'v1' do
      post '/areas', to: 'api#areas'
      post '/contains/:id', to: 'api#contains'
    end
    namespace 'v2' do

    end
  end

  post '*path', :to => 'application#routing_error'
  get '*path', :to => 'application#routing_error'
end
