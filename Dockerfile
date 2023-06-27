FROM jenkins/jenkins:latest

# disable the setup wizard as we will set up jenkins as code :)
ENV JAVA_OPTS -Djenkins.install.runSetupWizard=false

# copy the list of plugins we want to install
# run the install-plugins script to install the plugins
COPY plugins.txt /usr/share/jenkins/ref/plugins.txt
RUN jenkins-plugin-cli --plugin-file /usr/share/jenkins/ref/plugins.txt

# copy the config-as-code yaml file into the image
COPY casc.yaml /usr/local/jenkins-casc.yaml
# tell the jenkins config-as-code plugin where to find the yaml file
ENV CASC_JENKINS_CONFIG /usr/local/jenkins-casc.yaml

# copy the seedjob file into the image
COPY seedjob.groovy /usr/local/seedjob.groovy