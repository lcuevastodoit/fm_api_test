####  fm_api_test
Example project with Rails 6.1.4 and Ruby 2.7
#### Main features:
- This exanple app consumes data from Reqres.In api and save the data in a User model, then publish API endpoint for that data.
- It uses Swagger/OpenApi docs UI for API documentation.
- Some model an requests Rspec test are made (working ok)
- Ready for docker-compose
- Sidekiq and Redis Server for Reqres.in API pull scheduled job every 3 minutes

#### Requirements
- Docker
- Docker Compose
- Rails v6+
- Ruby 2.7+

#### Instalation
1. Clone the repository
2. docker-compose build
3. docker-compose run web rake db:create db:migrate
4. docker-compose up

Regards

LC
