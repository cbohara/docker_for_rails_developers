# The base image to use
# ruby:alpine gives us an alpine-bsed image with ruby installed from source.
FROM ruby:alpine

# Install dependencies:
RUN apk update && apk add --no-cache \
  autoconf \
  automake \
  bzip2 \
  bzip2-dev \
  ca-certificates \
  curl \
  curl-dev \
  file \
  g++ \
  gcc \
  geoip-dev \
  git \
  glib-dev \
  imagemagick \
  jpeg-dev \
  libc-dev \
  libevent-dev \
  libffi-dev \
  libpng-dev \
  libpq \
  libtool \
  libwebp-dev \
  libxml2-dev \
  libxslt-dev \
  linux-headers \
  make \
  nodejs \
  ncurses-dev \
  openssl-dev \
  patch \
  postgresql-dev \
  readline-dev \
  sqlite-dev \
  xz-dev \
  yaml-dev \
  zlib-dev

# Set an environment variable to store where the app is installed to inside
# of the Docker image.
ENV INSTALL_PATH /src/app
RUN mkdir -p $INSTALL_PATH

# This sets the context of where commands will be ran in and is documented
# on Docker's website extensively.
WORKDIR $INSTALL_PATH

# Ensure gems are cached and only get updated when they change.
COPY Gemfile Gemfile
RUN bundle install

# Copy in the application code from your work station at the current directory
# over to the working directory.
COPY . .

CMD ["bundle", "exec", "rails", "server", "-b", "0.0.0.0"]
