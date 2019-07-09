require 'rails_helper'
# Since it is the same for all versions (inherited from ApplicationController) we only check v1
describe 'POST /api/v1/areas' do

  context 'when the request is valid geojson feature collection' do

    before { post '/api/v1/areas', params: FakeGeo.feature_collection, as: :json}
    it 'creates an area' do
      expect(json['result']).not_to be_empty
    end

    it 'returns status code 201' do
      expect(response).to have_http_status(201)
    end
  end
  

  context 'when the request is valid geojson feature but not feature collection' do

    before { post '/api/v1/areas', params: FakeGeo.feature, as: :json}

    it 'returns status code 422' do
      expect(response).to have_http_status(422)
    end

    it 'returns a validation failure message' do
      expect(response.body)
      .to match(/{\"result\":null,\"message\":\"The provided geometric elements are incompatible\"}/)
    end

  end

  context 'when the request is invalid json' do
    before { post '/api/v1/areas', params: { } }

    it 'returns status code 422' do
      expect(response).to have_http_status(422)
    end

    it 'returns a validation failure message' do
      expect(response.body)
      .to match(/{\"result\":null,\"message\":\"The provided geometric elements are incompatible\"}/)
    end
  end

end
