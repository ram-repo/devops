#!/bin/bash

# Update package index
sudo apt update

# Install Java Development Kit
sudo apt install default-jdk -y

# Verify Java installation
java -version

# Create a new user for Tomcat
sudo useradd -m -d /opt/tomcat tomcat

# Set password for the tomcat user
echo "tomcat:tomcat" | sudo chpasswd

# Change shell to nologin for security
sudo chsh -s /sbin/nologin tomcat

# Create a temporary directory for downloading Tomcat
mkdir ~/tmp
cd ~/tmp

# Download Apache Tomcat
wget https://dlcdn.apache.org/tomcat/tomcat-10/v10.1.26/bin/apache-tomcat-10.1.26.tar.gz

# Extract Tomcat to /opt/tomcat
sudo tar -xzvf apache-tomcat-10.1.26.tar.gz -C /opt/tomcat --strip-components=1

# Change ownership of the Tomcat directory
sudo chown -R tomcat:tomcat /opt/tomcat/

# Make scripts in the bin directory executable
sudo chmod -R u+x /opt/tomcat/bin

# Create systemd service file for Tomcat
cat <<EOT | sudo tee /etc/systemd/system/tomcat.service
[Unit]
Description=Tomcat
After=network.target

[Service]
Type=forking

User=tomcat
Group=tomcat

Environment="JAVA_HOME=/usr/lib/jvm/java-1.21.0-openjdk-amd64/"
Environment="JAVA_OPTS=-Djava.security.egd=file:///dev/urandom"
Environment="CATALINA_BASE=/opt/tomcat"
Environment="CATALINA_HOME=/opt/tomcat"
Environment="CATALINA_PID=/opt/tomcat/temp/tomcat.pid"
Environment="CATALINA_OPTS=-Xms512M -Xmx1024M -server -XX:+UseParallelGC"

ExecStart=/opt/tomcat/bin/startup.sh
ExecStop=/opt/tomcat/bin/shutdown.sh

RestartSec=10
Restart=always

[Install]
WantedBy=multi-user.target
EOT

# Reload systemd daemon to recognize the new service
sudo systemctl daemon-reload

# Start the Tomcat service
sudo systemctl start tomcat

# Enable Tomcat service to start on boot
sudo systemctl enable tomcat

# Check the status of the Tomcat service
sudo systemctl status tomcat
