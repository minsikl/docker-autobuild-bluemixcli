FROM ubuntu:xenial

RUN apt-get update && apt-get install -y wget git sudo apt-transport-https
RUN wget -q -O - https://packages.cloudfoundry.org/debian/cli.cloudfoundry.org.key | sudo apt-key add -
RUN echo "deb http://packages.cloudfoundry.org/debian stable main" | sudo tee /etc/apt/sources.list.d/cloudfoundry-cli.list
RUN apt-get update && apt-get install cf-cli
RUN wget http://public.dhe.ibm.com/cloud/bluemix/cli/bluemix-cli/Bluemix_CLI_0.5.1_amd64.tar.gz \
    && tar -xvf Bluemix_CLI_0.5.1_amd64.tar.gz \
    && cd Bluemix_CLI \
    && /bin/bash ./install_bluemix_cli
