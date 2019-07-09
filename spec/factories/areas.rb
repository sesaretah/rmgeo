FactoryBot.define do
  factory :area do
    geo_json { FakeGeo.feature_collection.to_json }
  end
end
