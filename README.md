# Transparent Workplace

Hack4Equality brings together the global technology community to combat LGBTQ inequalities. Our seven-week hackathon is based in Los Angeles, but we're inviting the world to participate. Let's work together to spark change for millions around the world.

http://www.grindr.com/hack4equality/

## Challenge Sets

We want your brilliant minds to craft technology-based solutions to critical issues affecting the global LGBTQ community in the four challenge sets below. Important to keep in mind is Grindr's commitment to the cause and willingness to help: where appropriate, projects may benefit greatly from leveraging their tremendous reach and scale.

## Trans Visibility and Economic Empowerment

Trans people face an epidemic of unemployment. In the U.S., trans people are twice as likely as the general population to be unemployed, and 90% of those surveyed reported experiencing harassment or mistreatment the job, or took actions like hiding who they are to avoid discrimination. There are few digital platforms for trans-friendly employers to post jobs, career advice, or connect trans job seekers to educational resources. Similarly, no platform exists for trans people to review their employers based on how trans-friendly they are.


## Docker Notes

- build docker image based on Dockerfile

  - docker-compose build

- spin up and connect containers as directed in docker-compose.yml

  - docker-compose up -d

- run standard rails commands

  - docker-compose run app bundle install

  - docker-compose run app rails console

  - docker-compose run app rake routes

  - docker-compose run app rake db:reset db:migrate

  - docker-compose run app bundle exec rspec
