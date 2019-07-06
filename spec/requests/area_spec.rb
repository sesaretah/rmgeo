require 'rails_helper'

describe 'POST /api/v1/areas' do
  # valid payload

  context 'when the request is valid' do

    before { post '/api/v1/areas', params: FakeGeo.feature_collection, as: :json}
    it 'creates an area' do
      expect(json['result']).not_to be_empty
    end

    it 'returns status code 201' do
      expect(response).to have_http_status(201)
    end
  end

  context 'when the request is invalid' do
    before { post '/api/v1/areas', params: { geo_json: nil } }

    it 'returns status code 422' do
      expect(response).to have_http_status(422)
    end

    it 'returns a validation failure message' do
      expect(response.body)
      .to match(/{\"result\":null,\"message\":\"Invalid geo_json type\"}/)
    end
  end
end
