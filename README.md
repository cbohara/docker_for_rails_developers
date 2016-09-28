## Docker for Rails Developers

### Full write-up:

https://medium.com/@charlie.b.ohara/docker-for-rails-developers-5a2a6c2c0593#.3zv2j1fm1

### Cheat sheet:

- build docker image based on Dockerfile

  - docker-compose build

- spin up and connect containers as directed in docker-compose.yml

  - docker-compose up -d

- run standard rails commands

  - docker-compose run app bundle install

  - docker-compose run app rails console

  - docker-compose run app rake routes

  - docker-compose run app rake db:reset db:migrate

- testing with RSpec

  - docker-compose run app rake db:create db:migrate db:seed RAILS_ENV=test

  - docker-compose run app bundle exec rspec
