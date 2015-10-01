FROM vungle/base
MAINTAINER Eddie Simeon

RUN apt-get -y update
RUN apt-get -y install nodejs npm build-essential
RUN ln -s /usr/bin/nodejs /usr/bin/node
RUN mkdir -p /opt/pipeline-example

ADD . /opt/pipeline-example

EXPOSE 3000
