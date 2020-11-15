FROM ruby:2.7-alpine

ENV APP_HOME /book_review_api
ENV BUNDLE_PATH ${APP_HOME}/.data/gems

ENV DEV_PACKAGES="build-base postgresql-dev git tzdata"

RUN apk --update --upgrade add ${DEV_PACKAGES} && rm -rf /var/cache/apk/*

RUN mkdir -p ${APP_HOME}
WORKDIR ${APP_HOME}

COPY Gemfile* ${APP_HOME}/
RUN bundle config set clean 'true' && \
    bundle config set path ${BUNDLE_PATH} && \
    bundle install --jobs $(nproc)

ADD . ${APP_HOME}
