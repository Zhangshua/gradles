#! /bin/sh
config=".gradlesConfig"
source ~/$config
rw=`dirname $0`
SCRIPTPATH=$(cd $rw && pwd )
$SCRIPTPATH/spawnssh.sh $serverName $password "\"$1\""