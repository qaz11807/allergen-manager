FROM ruby:3.0.3-slim

ARG RAILS_ENV=development
ENV RAILS_ENV $RAILS_ENV
ENV DATABASE_HOST postgres

RUN apt-get update \
    && apt-get install -qq -y build-essential libpq5 libpq-dev --fix-missing --no-install-recommends

WORKDIR /allergen_manager_center

COPY Gemfile Gemfile.lock ./
RUN gem install bundler:2.3.4 \
    # && bundle config set --local without 'development test' \
    && bundle install \
    && apt-get remove -qq -y --purge build-essential libpq-dev \
    && apt-get autoremove -qq -y \
    && apt-get clean -qq -y

EXPOSE 3000

ENTRYPOINT ["bundle", "exec"]
CMD ["puma", "-C", "config/puma.rb"]

