require 'rails_helper'

describe 'POST /api/v3/locations' do

  context 'when the request is valid geojson feature collection' do

    before { post '/api/v3/locations', params: {name: Faker::Address.city}, as: :json}
    it 'creates a location' do
      expect(json['result']).not_to be_empty
    end

    it 'returns status code 201' do
      expect(response).to have_http_status(201)
    end
  end


  context 'when the request is invalid' do
    before { post '/api/v3/locations', params: { } }

    it 'returns status code 500' do
      expect(response).to have_http_status(500)
    end
  end
end
