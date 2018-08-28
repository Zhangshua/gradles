#! /usr/bin/expect -f

set timeout -1
set name [lindex $argv 0]
set password [lindex $argv 1]
set buildPath [lindex $argv 2]
set proPath [lindex $argv 3]

spawn scp -r $name:$buildPath/*/build/outputs/apk/* $proPath/

expect "password:"
send "$password\r"
interact