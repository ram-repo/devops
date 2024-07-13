#!/bin/bash

# Variables
TOMCAT_VERSION=10.1.26
TOMCAT_USER=tomcat
TOMCAT_GROUP=tomcat
TOMCAT_INSTALL_DIR=/opt/tomcat
TOMCAT_DOWNLOAD_URL=https://dlcdn.apache.org/tomcat/tomcat-10/v10.1.26/bin/apache-tomcat-$TOMCAT_VERSION.tar.gz
TOMCAT_SERVICE_FILE=/etc/systemd/system/tomcat.service

install_tomcat() {
    echo "Updating package index..."
    sudo apt update

    echo "Installing Java Development Kit..."
    sudo apt install default-jdk -y

    echo "Verifying Java installation..."
    java -version

    echo "Creating Tomcat user..."
    sudo useradd -m -d $TOMCAT_INSTALL_DIR $TOMCAT_USER
    echo "$TOMCAT_USER:$TOMCAT_USER" | sudo chpasswd
    sudo chsh -s /sbin/nologin $TOMCAT_USER

    echo "Creating temporary directory for downloading Tomcat..."
    mkdir -p ~/tmp
    cd ~/tmp

    echo "Downloading Apache Tomcat..."
    wget $TOMCAT_DOWNLOAD_URL

    echo "Extracting Tomcat to $TOMCAT_INSTALL_DIR..."
    sudo mkdir -p $TOMCAT_INSTALL_DIR
    sudo tar -xzvf apache-tomcat-$TOMCAT_VERSION.tar.gz -C $TOMCAT_INSTALL_DIR --strip-components=1

    echo "Changing ownership of Tomcat directory..."
    sudo chown -R $TOMCAT_USER:$TOMCAT_GROUP $TOMCAT_INSTALL_DIR

    echo "Making scripts in the bin directory executable..."
    sudo chmod -R u+x $TOMCAT_INSTALL_DIR/bin

    echo "Creating systemd service file for Tomcat..."
    sudo tee $TOMCAT_SERVICE_FILE > /dev/null <<EOT
[Unit]
Description=Tomcat
After=network.target

[Service]
Type=forking

User=$TOMCAT_USER
Group=$TOMCAT_GROUP

Environment="JAVA_HOME=/usr/lib/jvm/java-1.21.0-openjdk-amd64/"
Environment="JAVA_OPTS=-Djava.security.egd=file:///dev/urandom"
Environment="CATALINA_BASE=$TOMCAT_INSTALL_DIR"
Environment="CATALINA_HOME=$TOMCAT_INSTALL_DIR"
Environment="CATALINA_PID=$TOMCAT_INSTALL_DIR/temp/tomcat.pid"
Environment="CATALINA_OPTS=-Xms512M -Xmx1024M -server -XX:+UseParallelGC"

ExecStart=$TOMCAT_INSTALL_DIR/bin/startup.sh
ExecStop=$TOMCAT_INSTALL_DIR/bin/shutdown.sh

RestartSec=10
Restart=always

[Install]
WantedBy=multi-user.target
EOT

    echo "Reloading systemd daemon..."
    sudo systemctl daemon-reload

    echo "Starting Tomcat service..."
    sudo systemctl start tomcat

    echo "Enabling Tomcat service to start on boot..."
    sudo systemctl enable tomcat

    echo "Checking the status of the Tomcat service..."
    sudo systemctl status tomcat
}

uninstall_tomcat() {
    echo "Stopping Tomcat service..."
    sudo systemctl stop tomcat

    echo "Disabling Tomcat service..."
    sudo systemctl disable tomcat

    echo "Removing Tomcat systemd service file..."
    sudo rm -f $TOMCAT_SERVICE_FILE

    echo "Reloading systemd daemon..."
    sudo systemctl daemon-reload

    echo "Removing Tomcat directory..."
    sudo rm -rf $TOMCAT_INSTALL_DIR

    echo "Removing Tomcat user..."
    sudo userdel -r $TOMCAT_USER

    echo "Tomcat uninstalled successfully."
}

case "$1" in
    install)
        install_tomcat
        ;;
    uninstall)
        uninstall_tomcat
        ;;
    *)
        echo "Usage: $0 {install|uninstall}"
        exit 1
        ;;
esac

# chmod +x tomcat_setup.sh
# ./tomcat_setup.sh install
# ./tomcat_setup.sh uninstall
