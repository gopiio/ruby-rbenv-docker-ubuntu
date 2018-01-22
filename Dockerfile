#Use ubuntu as a base image
FROM ubuntu:latest

ARG version

#Install all the reuirements 
RUN apt-get update
RUN apt-get install -y curl git build-essential \
    python-software-properties
RUN apt-get install -y zlib1g-dev libssl-dev libreadline-dev \
    libyaml-dev libcurl4-openssl-dev \
    libffi-dev \
    libcurl4-openssl-dev
RUN curl -sL https://deb.nodesource.com/setup_8.x | bash - && \
    curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add - && \
    echo "deb https://dl.yarnpkg.com/debian/ stable main" | tee /etc/apt/sources.list.d/yarn.list
RUN apt-get update && apt-get install -y nodejs yarn

#Setup ENV variables
ENV PATH /usr/local/src/rbenv/shims:/usr/local/src/rbenv/bin:$PATH
ENV RBENV_ROOT /usr/local/src/rbenv
ENV RUBY_VERSION $version
ENV CONFIGURE_OPTS --disable-install-doc


RUN git clone https://github.com/rbenv/rbenv.git ${RBENV_ROOT} \
    && git clone https://github.com/rbenv/ruby-build.git ${RBENV_ROOT}/plugins/ruby-build \
    && ${RBENV_ROOT}/plugins/ruby-build/install.sh

RUN echo 'eval "$(rbenv init -)"' >> /etc/profile.d/rbenv.sh

RUN rbenv install $RUBY_VERSION \
&&  rbenv global $RUBY_VERSION
RUN gem install bundler





