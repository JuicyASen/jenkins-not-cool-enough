FROM jenkins/jenkins:lts-jdk11

# Skip the initial setup wizard
ENV JAVA_OPTS=-Djenkins.install.runSetupWizard=false

# Install suggested plugins and additional ones
COPY plugins.txt /usr/share/jenkins/ref/plugins.txt
RUN jenkins-plugin-cli -f /usr/share/jenkins/ref/plugins.txt

# Copy the Jenkins Configuration as Code files
COPY casc_configs/ /var/jenkins_casc_configs/

# Set the Jenkins Configuration as Code environment variable
ENV CASC_JENKINS_CONFIG=/var/jenkins_casc_configs/jenkins.yml

# Expose ports for HTTP and agent connections
EXPOSE 8080 50000

# Drop root privileges
USER jenkins