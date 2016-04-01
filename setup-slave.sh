#!/bin/sh
# Build locale used for message catalogs
locale-gen de_DE@euro || localedef --quiet -c -i de_DE -f ISO-8859-1 de_DE@euro

# set timezone
cp /usr/share/zoneinfo/Europe/Berlin /etc/localtime

# add our user
groupadd -g $JENKINS_UID jenkins_slave
useradd -d $JENKINS_HOME -s /bin/bash -m jenkins_slave -u $JENKINS_UID -g jenkins_slave
echo jenkins_slave:jpass | chpasswd

# add a virtualenv for build use
virtualenv ~jenkins_slave/py
~jenkins_slave/py/bin/pip install sshed

# make sure permissions are correct
chmod +x /usr/bin/startup.sh
chown -R $JENKINS_UID:$JENKINS_UID $JENKINS_HOME
