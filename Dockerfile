FROM ruby:2.7.1
RUN apt-get update -qq && apt-get install -y build-essential libpq-dev nodejs postgresql-client sudo telnet nano redis-server ssh tzdata \
&& curl -sL https://deb.nodesource.com/setup_16.x | sudo -E bash - && sudo apt-get update && apt-get install -y nodejs && \
curl -sL https://dl.yarnpkg.com/debian/pubkey.gpg | gpg --dearmor | sudo tee /usr/share/keyrings/yarnkey.gpg >/dev/null && \
echo "deb [signed-by=/usr/share/keyrings/yarnkey.gpg] https://dl.yarnpkg.com/debian stable main" | sudo tee /etc/apt/sources.list.d/yarn.list && \
sudo apt-get update && sudo apt-get install yarn && cp /usr/share/zoneinfo/America/Bogota /etc/localtime
RUN mkdir /app
WORKDIR /app
COPY Gemfile /app/Gemfile
COPY . /app
RUN gem install bundler
RUN bundle install
RUN yarn install
RUN bundle exec rails db:create db:migrate
RUN bundle exec rails db:seed
CMD ["bundle", "exec", "rails", "server"]