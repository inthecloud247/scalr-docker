FROM ubuntu:trusty

MAINTAINER Thomas Orozco <thomas@scalr.com>

RUN groupadd -r webapp && useradd -r -g webapp webapp

ENV APP_REPO https://github.com/scalr-tutorials/3-tier-app.git
ENV APP_VERSION v1.0.0
ENV APP_PATH /app

# Install Dependencies
RUN set -o errexit && set -o nounset \
    && apt-get update \
    && apt-get install --yes git python-mysqldb python-setuptools python-flask gunicorn \
    && rm -rf /var/lib/apt/lists/*

RUN set -o errexit && set -o nounset \
    && mkdir -p -- "${APP_PATH}" \
    && rm -rf -- "${APP_PATH}" \
    && git clone -b "${APP_VERSION}" "${APP_REPO}" "${APP_PATH}"

EXPOSE 8000

VOLUME /var/config
WORKDIR /app/app

USER webapp
ENTRYPOINT ["gunicorn", "--bind", "0.0.0.0:8000", "--access-logfile", "-", "--error-logfile", "-", "web:application"]
