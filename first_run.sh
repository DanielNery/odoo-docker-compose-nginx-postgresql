#!/bin/bash -e
set -e

##############################################################
#  Script     : first_run.sh
#  Author     : Hugo Rebelo <hugo.rebelo@indigoway.com>
#  Date       : 2018-10-26
#  Last Edited: 2019-01-21, Douglas Lambertinny
#  Description: Setup Odoo development environment
##############################################################

source ./include_utils.sh

check_so () {
	platform='unknown'
	unamestr=`uname`
	if [[ "$unamestr" == 'Linux' || "$unamestr" == 'Darwin'  ]]; then
	   	platform=$unamestr
		INFO "Platform: $platform"
    elif [[ "$unamestr" == 'Darwin' ]]; then
		INFO "Platform: $platform"
		INFO "Downloading Docker..."
        curl -o /tmp/Docker.dmg  https://download.docker.com/mac/stable/Docker.dmg
		INFO "Installing Docker..."
        open /tmp/Docker.dmg
	else
		ERROR "Unsupported platform. Aborting."
	fi
}

install_docker() {
    check_so
	# Check if Docker is installed
	if [ -x "$(command -v docker)" ]; then
		INFO "Docker already installed: $(docker --version)"
		# TODO: Ask to update
	else
        # Verify if platform is Linux
        if [[ "$platform" == 'Linux' ]]; then
		    INFO "Installing docker..."
		    curl -fsSL get.docker.com | sudo bash

        # Verify if platform is Mac
        elif [[ "$platform" == 'Darwin' ]]; then
            INFO "Downloading Docker..."
            curl -o /tmp/Docker.dmg  https://download.docker.com/mac/stable/Docker.dmg
            INFO "Installing Docker..."
            open /tmp/Docker.dmg
        else
            ERROR "Unsupported platform. Aborting."
        fi
    fi

    # Check if docker-compose is installed
    if [ -x "$(command -v docker-compose)" ]; then
        INFO "Docker-compose already installed: $(docker-compose --version)"
        # TODO: Ask to update
    else
        INFO "Installing docker-compose..."
        sudo curl -L "https://github.com/docker/compose/releases/download/1.23.2/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
        sudo chmod +x /usr/local/bin/docker-compose
    fi
}

install_submodules() {
	INFO "Installing submodules..."
	git submodule update --init --recursive --remote  -j 8
}

fix_permissions(){
	DATA_DIR="./odoo-web-data"
	if [[ -d $DATA_DIR ]]; then
		INFO "Running chmod on $DATA_DIR"
		sudo chmod 777 $DATA_DIR
	else
		INFO "Creating dir $DATA_DIR"
		sudo mkdir $DATA_DIR 
		INFO "Running chmod on $DATA_DIR"
		sudo chmod 777 $DATA_DIR
	fi
}

run_app(){
    INFO "Starting system..."
	sudo docker-compose up
}

install_docker
install_submodules
fix_permissions
run_app
