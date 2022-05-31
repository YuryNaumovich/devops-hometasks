FROM debian:buster

# File Author 
MAINTAINER Yury_Naumovich

# Set hostname
ENV HOSTNAME jenkins

# Update the repository sources list
RUN apt-get update && apt-get upgrade -y

# python3.8 need for latest ansible
RUN apt-get install -y build-essential zlib1g-dev libncurses5-dev libgdbm-dev libnss3-dev libssl-dev libsqlite3-dev libreadline-dev libffi-dev curl libbz2-dev wget
RUN wget https://www.python.org/ftp/python/3.8.2/Python-3.8.2.tgz
RUN tar xzf Python-3.8.2.tgz
RUN cd Python-3.8.2 && ./configure --enable-optimizations
RUN cd Python-3.8.2 && make -j 4
RUN cd Python-3.8.2 && make altinstall

# Install latest Ansible (>2.9)
RUN apt-get install -y curl ssh sudo gpg git 
RUN curl https://bootstrap.pypa.io/get-pip.py -o get-pip.py
RUN python3.8 get-pip.py
RUN sudo pip3 install ansible

# Depeneds for jenkins
RUN apt-get install -y openjdk-11-jre jq fontconfig net-tools daemon ca-certificates

# Docker
RUN apt-get install -y docker.io

# Install Jenkins
RUN wget https://pkg.jenkins.io/debian-stable/binary/jenkins_2.332.3_all.deb
RUN dpkg -i jenkins_2.332.3_all.deb && rm jenkins_2.332.3_all.deb

# Clean
RUN apt-get clean

# Install from sourse
#RUN curl -fsSL https://pkg.jenkins.io/debian-stable/jenkins.io.key | sudo tee /usr/share/keyrings/jenkins-keyring.asc > /dev/null
#RUN echo deb [signed-by=/usr/share/keyrings/jenkins-keyring.asc] https://pkg.jenkins.io/debian-stable binary/ | sudo tee /etc/apt/sources.list.d/jenkins.list > /dev/null
#RUN apt-get update -y && apt-get install -y jenkins 

RUN alias python=python3.8
RUN alias python3=python3.8

# Install 
RUN ansible-galaxy collection install community.general --ignore-errors

# Copy jenkins playbook
ADD jenkins.yml /opt/jenkins/playbook.yml

WORKDIR /opt/jenkins
RUN echo "localhost ansible_connection=local" > inventory 

WORKDIR /opt/jenkins
RUN ansible-playbook -i inventory playbook.yml 

# Open port 8080 for Jenkins
EXPOSE 8080

# Set ENV for Jenkins
ENV JAVA_ARGS="-Dfile.encoding=UTF-8 -Dsun.jnu.encoding=UTF-8"
ENV JENKINS_HOME '/var/lib/jenkins'

# Set Locale (BUG: Malformed input or input contains unmappable characters)
ENV LANG C.UTF-8
ENV LC_ALL C.UTF-8

# Start Jenkins
WORKDIR /var/lib/jenkins
CMD jenkins start
