FROM ubuntu:xenial

RUN apt-get update && apt-get install -y wget git sudo apt-transport-https curl ca-certificates software-properties-common
RUN wget -q -O - https://packages.cloudfoundry.org/debian/cli.cloudfoundry.org.key | sudo apt-key add -
RUN curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
RUN add-apt-repository \
   "deb [arch=amd64] https://download.docker.com/linux/ubuntu \
   $(lsb_release -cs) \
   stable"
RUN echo "deb http://packages.cloudfoundry.org/debian stable main" | sudo tee /etc/apt/sources.list.d/cloudfoundry-cli.list
RUN apt-get update && apt-get install -y cf-cli docker-ce
RUN wget http://public.dhe.ibm.com/cloud/bluemix/cli/bluemix-cli/Bluemix_CLI_0.5.3_amd64.tar.gz \
    && tar -xvf Bluemix_CLI_0.5.3_amd64.tar.gz \
    && cd Bluemix_CLI \
    && /bin/bash ./install_bluemix_cli
RUN bx plugin install IBM-Containers -r Bluemix \
    && bx plugin install container-service -r Bluemix
RUN curl -LO https://storage.googleapis.com/kubernetes-release/release/$(curl -s https://storage.googleapis.com/kubernetes-release/release/stable.txt)/bin/linux/amd64/kubectl \
    && chmod +x ./kubectl \
    && mv ./kubectl /usr/local/bin/kubectl
