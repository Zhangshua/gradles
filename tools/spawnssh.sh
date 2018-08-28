#! /usr/bin/expect -f

set timeout -1
set name [lindex $argv 0]
set password [lindex $argv 1]
set commandStr [lindex $argv 2]
spawn ssh $name "eval $commandStr"

expect "password:"
send "$password\r"
expect "SUCCESSFUL"
