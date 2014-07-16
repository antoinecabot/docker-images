#This Dockerfile is used to build an image containing basic stuff to be used as a Jenkins slave build node.
FROM centos:latest
MAINTAINER Antoine Cabot <antoinecabot@gmail.com>


# Install a basic SSH server
RUN yum install -y openssh-server
RUN mkdir -p /var/run/sshd

# Install JDK 7 (latest edition)
RUN yum install -y java-1.7.0-openjdk

# Install GIT
RUN yum install -y git

# Add user jenkins to the image
RUN adduser jenkins
# Set password for the jenkins user (you may want to alter this).
RUN echo "jenkins:jenkins" | chpasswd

# Add ssh base keys to run sshd
RUN ssh-keygen -b 1024 -t rsa -f /etc/ssh/ssh_host_key -q -N ""
RUN ssh-keygen -b 1024 -t rsa -f /etc/ssh/ssh_host_rsa_key -q -N ""
RUN ssh-keygen -b 1024 -t dsa -f /etc/ssh/ssh_host_dsa_key -q -N ""

# Standard SSH port
EXPOSE 22

CMD ["/usr/sbin/sshd", "-D"]