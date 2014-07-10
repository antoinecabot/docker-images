#This Dockerfile is used to build an image containing basic stuff to be used as a Jenkins slave build node.
FROM centos:latest
MAINTAINER Antoine Cabot <antoinecabot@gmail.com>


# Install a basic SSH server
RUN yum install -y openssh-server
RUN mkdir -p /var/run/sshd

# Install JDK 7 (latest edition)
RUN yum install -y java-1.7.0-openjdk

# Add user jenkins to the image
RUN adduser jenkins
# Set password for the jenkins user (you may want to alter this).
RUN echo "jenkins:jenkins" | chpasswd

# Standard SSH port
EXPOSE 22

CMD ["/usr/sbin/sshd", "-D"]