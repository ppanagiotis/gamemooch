# vim:set ft=dockerfile:
FROM debian:stretch
MAINTAINER ppanagiotis <ppanagiotis@asilo.gr>

RUN apt-get -qq update --fix-missing

RUN apt-get -y install wget openjdk-8-jre --fix-missing

RUN wget -O /tmp/elasticsearch-5.3.1.deb https://artifacts.elastic.co/downloads/elasticsearch/elasticsearch-5.3.0.deb
RUN dpkg -i /tmp/elasticsearch-5.3.1.deb

ENV PATH /usr/share/elasticsearch/bin:$PATH

WORKDIR /usr/share/elasticsearch

COPY config ./config

RUN mkdir logs
RUN mkdir data

RUN chown -R elasticsearch:elasticsearch config
RUN chown -R elasticsearch:elasticsearch logs
RUN chown -R elasticsearch:elasticsearch data

EXPOSE 9200 9300

USER elasticsearch

CMD ["elasticsearch"]
