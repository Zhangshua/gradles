#! /bin/sh
config=".gradlesConfig"
startTime=`date +%s`
cd ~
home=`pwd`
cd -
myPath="$home/$config"

rw=`dirname $0`

SCRIPTPATH=$(cd $rw && pwd )/tools/


init(){
    read -p "请输入你的英文名"  name
    echo "userName=$name" > ~/$config

    read -p "请输入git仓库"  gitRepo
    echo "gitRepo=$gitRepo" >> ~/$config

    read -p "请输入服务器账号"  serverName
    echo "serverName=$serverName" >> ~/$config

    read -p "请输入服务器密码"  password
    echo "password=$password" >> ~/$config

    read -p "请输入服务器路径"  path
    echo "path=$path" >> ~/$config

    echo "buildPath=$path/gradles/$name/*/" >> ~/$config

    git remote remove fork
    git remote add fork $gitRepo && git fetch && $SCRIPTPATH/loginssh.sh "cd $path && mkdir -p gradles && cd gradles && rm -rf $name && mkdir -p  $name && cd $name && git clone $gitRepo && cd */ && git checkout -b $name && exit"
}

if [ ! -e "$myPath" ]
then
 	init
fi

source ~/$config

remoteName=$(echo `git remote` | grep "fork")

if [[ $remoteName == "" ]]
then
    git remote add fork $gitRepo && git fetch
fi

commitCode(){
    git add ./ && git commit -m 'gradles auto commit'
    commitResut=$?
    git push fork :$userName
    branch=`git symbolic-ref --short HEAD`
    git push fork $branch:$userName
    if [ $commitResut -eq 0 ]; then
    git reset --soft HEAD^
    fi

    rm -rf build/outputs/apk/
    mkdir -p build/outputs/apk/
}

build(){
    $SCRIPTPATH/loginssh.sh "cd $buildPath && git checkout master && git pull && git branch -D $userName && git checkout -b $userName --track remotes/origin/$userName && rm -rf */build/outputs/apk/ && ./gradlew $* &&rm -rf *.hprof && exit"
}

commitCode && build $*  && $SCRIPTPATH/scp.sh $serverName  $password $buildPath "build/outputs/apk/"


endTime=`date +%s`
useTime=`expr $endTime - $startTime`
min=`expr $useTime / 60`
sec=`expr $useTime % 60`
echo "buildTime:${min}分${sec}秒"
date "+%Y-%m-%d %H:%M:%S"