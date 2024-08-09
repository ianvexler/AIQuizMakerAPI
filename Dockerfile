FROM ruby:3.3.0-slim-bullseye AS base

# Install jemalloc
RUN apt-get update && apt-get install -y --no-install-recommends libjemalloc2 && rm -rf /var/lib/apt/lists/*
ENV LD_PRELOAD=/usr/lib/x86_64-linux-gnu/libjemalloc.so.2

WORKDIR /app

# Install necessary dependencies for MySQL (development) and PostgreSQL (production)
RUN apt-get update \
  && apt-get install -y --no-install-recommends \
  build-essential \
  curl \
  libpq-dev \
  default-libmysqlclient-dev \
  nodejs \
  yarn \
  && rm -rf /var/lib/apt/lists/* /usr/share/doc /usr/share/man \
  && apt-get clean \
  && useradd --create-home ruby \
  && chown ruby:ruby -R /app

USER ruby

# Bundle install
COPY --chown=ruby:ruby Gemfile* ./
RUN bundle install --jobs "$(nproc)"

###############################################################################

FROM base AS app

COPY --chown=ruby:ruby bin/ ./bin
RUN chmod 0755 bin/*

ARG RAILS_ENV="production"
ENV RAILS_ENV="${RAILS_ENV}" \
    PATH="${PATH}:/home/ruby/.local/bin" \
    USER="ruby"

COPY --chown=ruby:ruby . .

# Precompile assets if not in development
RUN if [ "${RAILS_ENV}" != "development" ]; then \
  SECRET_KEY_BASE=dummyvalue \
  NO_SECRETS=1 \
  REDIS_URL=redis://redis:6379/1 \
  rails assets:precompile; fi

CMD ["bash"]

ENTRYPOINT ["bundle", "exec"]

EXPOSE 3000

CMD ["rails", "s"]
