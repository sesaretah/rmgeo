module FakeGeo
  extend self
  def feature_collection
    #Every feature collection has set of featues for simplicity here we include few features
    return {type: 'FeatureCollection', "features": FakeGeo.feature(rand(2..3))}
  end

  def feature(no = 1, type= 'polygon')
    features = []
    for i in 1..no
      #Every feutre has set of properties and at least 3 points that a bounding polygons of that ...
      # ... points forms the polygon
      features << {type: "Feature", geometry: FakeGeo.send(type), properties: {name: Faker::Lorem.word}}
    end
    # To handle special case when a geojson polygon or point is needed
    if no > 1
      return features
    else
      return features[0]
    end
  end

  #To get geojson polygon, FakeGeo.feature(1, 'polygon') must be called
  def polygon
    return { "type": "Polygon", "coordinates": [FakeGeo.latlon(rand(3..6))]}
  end

  def latlon(no = 3)
    latlons = []
    for i in 1..no
      #Here we use Faker gem to get random points i.e., points with longitude and latitude tuple
      latlons << [Faker::Address.latitude, Faker::Address.longitude]
    end
    #first and last position must be the same
    if no > 1
      latlons << latlons[0]
    end
    return latlons
  end

  #To get geojson point, FakeGeo.feature(1, 'point') must be called
  def point
    return { "type": "Point", "coordinates": FakeGeo.latlon(1)[0]}
  end
end
