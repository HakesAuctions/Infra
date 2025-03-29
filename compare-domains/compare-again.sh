#!/bin/bash

# This script will create a  visual comparison of the
# output of the two DNS servers defined as NS0 and
# NS1 for the fqdn defined in DOMAINS
#
# Created: 2018-05-27
# Author: Sebastian <sebastian@progether.com>
#
# Source: https://stackoverflow.com/a/29079962/683977

# Bash Colors
# Source: https://stackoverflow.com/a/5413029
BLACK=$(tput setaf 0)
RED=$(tput setaf 1)
GREEN=$(tput setaf 2)
YELLOW=$(tput setaf 3)
LIME_YELLOW=$(tput setaf 190)
POWDER_BLUE=$(tput setaf 153)
BLUE=$(tput setaf 4)
MAGENTA=$(tput setaf 5)
CYAN=$(tput setaf 6)
WHITE=$(tput setaf 7)
BRIGHT=$(tput bold)
NORMAL=$(tput sgr0)
BLINK=$(tput blink)
REVERSE=$(tput smso)
UNDERLINE=$(tput smul)

# Define the nameservers for comparison
NS0="mail3.diamondcomics.com"
NS1="ns-1716.awsdns-22.co.uk"

# List your fqdn to be checked
DOMAINS=$(<alldomains.txt)
# DOMAINS=(
#     "google.com"
#     "microsoft.com"
# )

for DOMAIN in ${DOMAINS[@]}; do
    printf "Checking %s" $DOMAIN
    DIFF=$(colordiff <(sort -u <(dig +nottlid +noall +answer @${NS0} ${DOMAIN} ANY) ) <(sort -u <(dig +nottlid +noall +answer @${NS1} ${DOMAIN} ANY) ))
    if [ "$DIFF" != "" ]; then
        printf "\n%s\n\n" "$DIFF"
    else
        printf ": ${BLUE}no difference${NORMAL}\n"
    fi
done
