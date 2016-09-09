FROM       rodrigosaito/java8

MAINTAINER Rodrigo Saito <rodrigo.saito@gmail.com>

ENV MAVEN_VERSION 3.3.3

# Default to UTF-8 file.encoding
ENV LANG C.UTF-8

RUN apt-get update && apt-get install -y openssh-client curl mysql-client build-essential

RUN curl -sL https://deb.nodesource.com/setup_4.x | bash -

RUN apt-get update && apt-get install -y nodejs

# Installing Mocha/Chai/Supertest
RUN \
    npm install -g mocha \
    && npm install supertest --save-dev \
    && npm install chai \
    && npm install chai3-json-schema \
    && npm install mockserver-client
    
RUN curl -fsSL http://archive.apache.org/dist/maven/maven-3/$MAVEN_VERSION/binaries/apache-maven-$MAVEN_VERSION-bin.tar.gz | tar xzf - -C /usr/share \
  && mv /usr/share/apache-maven-$MAVEN_VERSION /usr/share/maven \
  && ln -s /usr/share/maven/bin/mvn /usr/bin/mvn

ENV MAVEN_HOME /usr/share/maven

CMD ["mvn"]
