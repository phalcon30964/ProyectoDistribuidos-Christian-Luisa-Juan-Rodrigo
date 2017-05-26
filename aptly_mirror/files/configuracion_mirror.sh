#!/bin/bash
# Read and split array that contain the dependencies defined by user.
IFS=', ' read -r -a array <<< "${deps}"
# Split symbol (used to separate dependencies)
symbol=" | "
# Base Filter (contains required, important and standard Aptly dependencies)
mirrorFilter="Priority (required) | Priority (important) | Priority (standard) "
# Add dependencies to filter
for package in "${array[@]}"
do
 mirrorFilter=$mirrorFilter$symbol$package
done
# Add new dependencies to mirror's filter
aptly mirror edit -filter="$mirrorFilter" mirror-xenial
# Update mirror's dependencies
aptly mirror update mirror-xenial
# Create mirror's snapshot
aptly snapshot create mirror-snap-xenial from mirror mirror-xenial
# Publish mirror's snapshot
./aptly_expect.sh
# Start mirror's service
aptly serve
