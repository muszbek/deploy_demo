FROM bitwalker/alpine-elixir-phoenix:1.14

RUN apk --no-cache --update add \
	postgresql-client && \
    rm -rf /var/cache/apk/*

COPY . /opt/app

RUN mix deps.get && \
    MIX_ENV=prod mix deps.compile && \
    MIX_ENV=prod mix phx.digest

CMD ["./entrypoint.sh"]
