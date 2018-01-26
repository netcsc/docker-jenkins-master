FROM jenkins/jenkins:lts

COPY plugins.txt /usr/share/jenkins/ref/plugins.txt
RUN /usr/local/bin/install-plugins.sh < /usr/share/jenkins/ref/plugins.txt

USER root
RUN apt-get update && apt-get install -y vim
RUN apt-get install -y make
RUN apt-get install -y apt-transport-https
RUN apt-get install -y ca-certificates
RUN apt-get install -y curl
RUN apt-get install -y software-properties-common
RUN curl -fsSL https://download.docker.com/linux/$(. /etc/os-release; echo "$ID")/gpg | apt-key add -
RUN add-apt-repository  "deb [arch=amd64] https://download.docker.com/linux/debian stretch stable"
RUN apt-get update
RUN apt-get install -y docker-ce

RUN curl -o apache-maven-3.5.2-bin.tar.gz http://mirror.dsrg.utoronto.ca/apache/maven/maven-3/3.5.2/binaries/apache-maven-3.5.2-bin.tar.gz
RUN tar xzfv /apache-maven-3.5.2-bin.tar.gz  -C /

RUN apt-get install -y python python-pip
RUN pip install awscli

RUN mkdir -p /root/.docker
COPY config.json /root/.docker/
#COPY docker-credential-ecr-login /usr/local/bin/
#RUN chmod a+x /usr/local/bin/docker-credential-ecr-login
#COPY artifactory-settings.xml /var/lib/jenkins/artifactory-settings.xml