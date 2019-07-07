require 'rails_helper'

describe 'POST /api/v1/contains/:id' do
  # valid payload
  let!(:areas) { create_list(:area, 10) }
  let(:area_id) { areas.first.id }

  context 'when the request is valid geojson point' do

    before { post "/api/v1/contains/#{area_id}", params: FakeGeo.feature(1, 'point'), as: :json}
    it 'creates an area' do
      expect(json['result']).not_to be_empty
    end

    it 'returns status code 200' do
      expect(response).to have_http_status(200)
    end
  end

  context 'when the request is invalid' do
    before { post "/api/v1/contains/#{area_id}", params: {}, as: :json}

    it 'returns status code 422' do
      expect(response).to have_http_status(422)
    end

    it 'returns a validation failure message' do
      expect(response.body)
      .to match(/{"result":null,"message":"The provided geometric elements are incompatible"}/)
    end
  end
end
