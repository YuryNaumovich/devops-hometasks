FROM debian:latest

# File Author 
MAINTAINER Yury_Naumovich

# Set hostname
#ENV HOSTNAME jenkins

# Update the repository sources list
RUN apt-get update && apt-get upgrade -y

# Install and run apache
RUN apt-get install -y ansible curl ssh sudo gpg git && apt-get clean

# Copy jenkins playbook
ADD jenkins.yml /opt/jenkins/playbook.yml

WORKDIR /opt/jenkins
RUN echo "localhost ansible_connection=local" > inventory 

WORKDIR /opt/jenkins
RUN ansible-playbook -i inventory playbook.yml

# Open port 8080 for Jenkins
EXPOSE 8080

#ENV JAVA_OPTS=-Djenkins.install.runSetupWizard=false
ENV JAVA_ARGS="-Dfile.encoding=UTF-8 -Dsun.jnu.encoding=UTF-8"
ENV JENKINS_HOME '/var/lib/jenkins'

# Set Locale (BUG: Malformed input or input contains unmappable characters)
ENV LANG C.UTF-8
ENV LC_ALL C.UTF-8

# Docker
RUN apt-get install -y docker.io

# Docker-agent for Jenkins
#RUN groupadd docker
RUN usermod -aG docker jenkins

USER jenkins
WORKDIR /var/lib/jenkins
CMD jenkins start
