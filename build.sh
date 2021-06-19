#!/bin/bash
##########################################################################################
#		
#   Project: ft_server	
#				                                    
#	Version 0.1
#	by:@mvaldeta
#
#	enjoy :)
#########################################################################################
########################################################################################
# START
########################################################################################
########################################################################################
# stop running in case comands fails
########################################################################################
set -eu
########################################################################################
# set up message color
########################################################################################
BLUE='\033[01;36m'
########################################################################################
echo "${BLUE}--------------------------------------------------------"
echo "${BLUE}************* WELCOME TO LEMP SERVER SETUP *************"
echo "${BLUE}--------------------------------------------------------"
########################################################################################
# start docker
########################################################################################
docker build -t ft_server:latest . 