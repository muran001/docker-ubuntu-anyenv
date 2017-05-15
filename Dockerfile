FROM ubuntu:latest

MAINTAINER muran001 <macmuran001@gmail.com>

RUN apt-get update \
  &&  apt-get upgrade -y --force-yes \
  &&  apt-get install -y --force-yes \
      libssl-dev \
      libreadline-dev \
      zlib1g-dev \
      language-pack-ja \
      curl \
      git \
      build-essential \
      vim \
      dtach \
      imagemagick \
      libmagick++-dev \
      libqtwebkit-dev \
      libffi-dev \
      mysql-client \
      libmysqlclient-dev \
      libxslt1-dev \
      redis-tools \
      xvfb \
      nodejs \
      npm \
  && apt-get clean \
  && rm -rf /var/cache/apt/archives/* /var/lib/apt/lists/*

ENV LANG=ja_JP.UTF-8
RUN update-locale LANG=ja_JP.UTF-8
ENV TZ Asia/Tokyo
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

RUN git clone https://github.com/riywo/anyenv /usr/local/anyenv \
  && git clone https://github.com/znz/anyenv-update.git /usr/local/anyenv/plugins/anyenv-update
ENV PATH /usr/local/anyenv/bin:$PATH

RUN echo 'export ANYENV_ROOT=/usr/local/anyenv' >> /etc/profile.d/anyenv.sh \
  && echo 'export PATH=/usr/local/anyenv/bin:$PATH' >> /etc/profile.d/anyenv.sh \
  && echo 'eval "$(anyenv init -)"' >> /etc/profile.d/anyenv.sh

RUN echo 'export ANYENV_ROOT=/usr/local/anyenv' >> /root/.bashrc \
  && echo 'export PATH=/usr/local/anyenv/bin:$PATH' >> /root/.bashrc \
  && echo 'eval "$(anyenv init -)"' >> /root/.bashrc

RUN /bin/bash -l -c 'anyenv install rbenv'
RUN /bin/bash -l -c 'anyenv install ndenv'
