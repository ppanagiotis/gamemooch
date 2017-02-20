# vim:set ft=dockerfile:
FROM debian:stretch
MAINTAINER ppanagiotis <ppanagiotis@asilo.gr>

# Install system dependencies

RUN apt-get -qq update

RUN apt-get install -y --fix-missing ruby ruby-dev zlib1g-dev build-essential git default-libmysqlclient-dev nodejs

ENV PORT 3000
ENV APP_NAME gamemooch
ENV APP_DIR /srv/${APP_NAME}

ENV REPO_HOST github.com
ENV REPO_USER git
ENV REPO_URL ${REPO_USER}@${REPO_HOST}:ppanagiotis/${APP_NAME}.git

EXPOSE ${PORT}

RUN mkdir -p ${APP_DIR}

COPY deploy/keys/id_rsa /root/.ssh/
COPY deploy/keys/known_hosts /root/.ssh/
RUN chmod 600 /root/.ssh/id_rsa
RUN ssh-keyscan github.com >> ~/.ssh/known_hosts

WORKDIR ${APP_DIR}


RUN git clone -q ${REPO_URL} .

RUN gem install rails

RUN bundle install

COPY deploy/database.yml ${APP_DIR}/${APP_NAME}/config/database.yml

COPY deploy/entrypoint.sh /etc/service/${APP_NAME}/run

CMD /etc/service/${APP_NAME}/run
