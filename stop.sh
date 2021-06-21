#!/bin/bash
#########################################################################
#   Project: ft_server
#	Version 0.1
#	by:@mvaldeta
#	enjoy :)
########################################################################
# STOP
#########################################################################
# stop running in case comands fails
#########################################################################

set -eu

#########################################################################
# set up message color
#########################################################################

BLUE='\033[01;36m'
echo "${BLUE}--------------------------------------------------------"
echo "${BLUE}******************* STOPING DOCKER *********************"
echo "${BLUE}--------------------------------------------------------"

#########################################################################
# STOP IMAGE & CLEAR
#########################################################################

docker stop ft_server && \
docker rm   ft_server
