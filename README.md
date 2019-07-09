# Rails GEOJSON-based Point-in-Polygon API
Given a set of polygons and a point, this API checks wheter the point falls whithin one of polygons or not. This problem is well-known in computational geomtry as [point-in-polygon (PIP)](https://en.wikipedia.org/wiki/Point_in_polygon) problem. The acceptable format for both point and area is the standardized [GeoJson](https://geojson.org/) format.

## Getting Started
To get the Rails server running locally:
* [Install ruby on rails on your machine](https://gorails.com/setup)
* Clone this repo
* `bundle install` to install all req'd dependencies
* `rake db:migrate` to make all database migrations
* `rails s` to start the local server
## Usage
For full documentaion please refer to the [project's homepage](https://warm-tor-85726.herokuapp.com/)
## Running the tests

`bundle exec rspec`

## Authors

* *Hossein Shafiei* - [sesaretah](https://github.com/sesaretah)

## License

This project is licensed under the MIT License - see the [LICENSE.md](LICENSE.md) file for details
