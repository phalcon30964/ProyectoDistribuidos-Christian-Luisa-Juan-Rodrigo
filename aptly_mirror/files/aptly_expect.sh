#!/usr/bin/expect -f
# The spawn command inits the expect process, the aptly command publishes the snapshot
spawn aptly publish snapshot mirror-snap-xenial
# Expected stdout and responses 
expect "Enter passphrase:"
send -- "password\r"
expect "Enter passphrase:"
send -- "password\r"
# Interaction finished
expect eof
