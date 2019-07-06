Rails.application.routes.draw do
  namespace 'api' do
    namespace 'v1' do
      post '/areas', to: 'api#areas'
      post '/contains/:id', to: 'api#contains'
    end
    namespace 'v2' do

    end
  end
end
