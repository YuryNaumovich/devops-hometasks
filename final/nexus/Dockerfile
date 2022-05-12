###  NEXUS
FROM debian:latest

# File Author 
MAINTAINER Yury_Naumovich

# Update the repository sources list
RUN apt-get update && apt-get upgrade -y

# Install and run apache
RUN apt-get install -y ansible curl sudo wget ssh && apt-get clean

# Ansible install Nexus
ADD nexus.yml /opt/nexus/playbook.yml

WORKDIR /opt/nexus
RUN echo "localhost ansible_connection=local" > inventory

WORKDIR /opt/nexus
RUN ansible-playbook -i inventory playbook.yml

# Open port 8081 for Nexus
EXPOSE 8081

USER root
CMD ["/opt/nexus-3.38.1-01/bin/nexus", "run"]
