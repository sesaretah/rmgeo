web: bin/rails server -p $PORT -e $RAILS_ENV
hardworker: bundle exec sidekiq -c 2
worker: bundle exec jobs:work