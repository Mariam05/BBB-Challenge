FROM ruby:2.7.1
RUN curl https://deb.nodesource.com/setup_12.x | bash
RUN curl https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add -
RUN echo "deb https://dl.yarnpkg.com/debian/ stable main" | tee /etc/apt/sources.list.d/yarn.list
RUN apt-get update -qq && apt-get install -y nodejs postgresql-client yarn
RUN mkdir /bbb-demo2
WORKDIR /bbb-demo2

# Setting env up
ENV RAILS_ENV='production'
ENV RACK_ENV='production'


COPY Gemfile /bbb-demo2/Gemfile
COPY Gemfile.lock /bbb-demo2/Gemfile.lock
RUN bundle install
RUN yarn install --check-files
COPY . /bbb-demo2
# RUN rake db:create db:migrate db:seed

# Add a script to be executed every time the container starts.
COPY entrypoint.sh /usr/bin/
RUN chmod +x /usr/bin/entrypoint.sh
ENTRYPOINT ["entrypoint.sh"]
EXPOSE 3000

# Start the main process.
CMD ["RAILS_ENV=production", "rails", "server", "-b", "0.0.0.0"]