FROM elixir:1.8.1
RUN apt-get update && \
  apt-get install -y net-tools

ENV APP_HOME /app
RUN mkdir $APP_HOME

#load bits
WORKDIR $APP_HOME
COPY . $APP_HOME
RUN mix local.hex --force && mix deps.get && mix local.rebar
RUN mix compile

# Upload source
EXPOSE 8080

# Start server
CMD ["mix", "run", "--no-halt"]