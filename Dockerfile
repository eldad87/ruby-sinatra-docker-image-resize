FROM ruby:2.4

RUN apt-get update && \
    apt-get install -y net-tools

# Upload source
COPY ./app /app

# Install gems
ENV APP_HOME /app
ENV HOME /root
WORKDIR $APP_HOME
RUN bundle install

ENV PORT 3000
EXPOSE 3000
CMD ["ruby", "hello.rb"]