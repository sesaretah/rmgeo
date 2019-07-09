require 'rails_helper'

describe 'POST /api/vx/contains/:id' do

  let!(:areas) { create_list(:area, 10) }
  let!(:sample_area) {areas.first}
  let(:area_id) { areas.first.id }

  context 'when the request is valid geojson point' do

    before { post "/api/v1/contains/#{area_id}", params: FakeGeo.feature(1, 'point'), as: :json}
    it 'receives the results' do
      expect(json['result']).not_to be_empty
    end

    it 'returns status code 200' do
      expect(response).to have_http_status(200)
    end
  end

  context 'when the request for v1 is a point inside area' do
    #Since we know that centroid is inside the polygon
    before { post "/api/v1/contains/#{area_id}", params: { "type": "Feature", "geometry": RGeo::GeoJSON.encode(RGeo::GeoJSON.decode(sample_area.geo_json)[0].geometry.centroid), "properties": { "name": "test" }}, as: :json}

    it 'receives inside true' do
      expect(json['result'][0]['inside']).to be true
    end

    it 'returns status code 200' do
      expect(response).to have_http_status(200)
    end
  end

  # V2 and V3 use same method which is different from v1
  context 'when the request for v2/v3 is a point inside area' do
    #Since we know that centroid is inside the polygon
    before { post "/api/v2/contains/#{area_id}", params: { "type": "Feature", "geometry": RGeo::GeoJSON.encode(RGeo::GeoJSON.decode(sample_area.geo_json)[0].geometry.centroid), "properties": { "name": "test" }}, as: :json}

    it 'receives inside true' do
      expect(json['result'][0]['inside']).to be true
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
      .to match(/{"result":null,"message":"Invalid geo_json type"}/)
    end
  end
end
