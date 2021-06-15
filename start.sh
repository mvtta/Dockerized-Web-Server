#!/bin/bash
#########################################################################
# START
#########################################################################
#########################################################################
# stop running in case comands fails
#########################################################################
set -eu
#########################################################################
# set up message color
#########################################################################
BLUE='\033[01;36m'
#########################################################################
echo "${BLUE}--------------------------------------------------------"
echo "${BLUE}************* WELCOME TO LEMP SERVER SETUP *************"
echo "${BLUE}--------------------------------------------------------"
#########################################################################
# start docker
#########################################################################
docker build -t ft_server . && \
docker run --name ft_server -it -p 80:80 -p 443:443 ft_server