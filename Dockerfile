FROM ubuntu:16.04

LABEL maintainer="rmontesg@resuelve.mx"

ENV PYTHONUNBUFFERED 1

RUN apt-get clean && \
  apt-get update && \
  apt-get install -y locales python python-pip

RUN pip install -U pip pyinstaller

# Set the locale
RUN locale-gen en_US.UTF-8
ENV LANG en_US.UTF-8
ENV LANGUAGE en_US:en
ENV LC_ALL en_US.UTF-8

RUN apt-get update && apt-get install wget -y && \
  wget https://packages.erlang-solutions.com/erlang-solutions_1.0_all.deb && \
  dpkg -i erlang-solutions_1.0_all.deb && \
  rm erlang-solutions_1.0_all.deb && \
  apt-get update && \
  apt-get install esl-erlang elixir -y

RUN mix local.hex --force && \
    mix local.rebar --force

RUN mix archive.install https://github.com/phoenixframework/archives/raw/master/phx_new.ez

VOLUME /app/src/deps
VOLUME /app/src/_build
