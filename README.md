# gradles
 
详细说明见[简书博客](https://www.jianshu.com/p/d1b17185bc5a)

## 前言
随着Android项目规模的扩大，编译时间是越来越长。除了一些优化手段，提升硬件配置是提高编译速度最直接有效的方法。考虑到成本，公司不可能给每个人都配一个电脑，但公司往往都有一台性能较好的服务器。我们就想到利用服务器来加快编译速度。

该脚本的作用就是自动将编译过程放于服务器上进行，对使用者来说是完全透明的。


>另外，使用该方法会有额外的上传代码和下载代码的消耗，使用前请确保 额外的时间+服务器编译时间<本地编译时间

## 使用方法

1. 安装
执行下面的命令：
```
$ git clone git@github.com:Zhangshua/gradles.git  
$ cd gradles
$ echo "export PATH=$(pwd)/:\$PATH" >>~/.bash_profile
$ source ~/.bash_profile
```
2.  初始化
进入Android 项目的根目录，执行
```
$ gradles 
按照如下提示输入相关信息：
please input your name: zhangsan （输入一个唯一的名字，用于和公司其他同事区分开）
please input git repositories to sync code: git@XXX （git仓库地址，用于同步开发临时代码。可以使用项目的git仓库，但会造成大量临时的提交，所以建议专门建立一个用于服务器编译的git仓库）
please input server's 'user@host' : root@192.168.1.1 （服务器地址）
please input server's password: 123456 （服务器密码）
please input server's path to build: /home/ （服务器上放置编译代码的路径）
```
3.  使用
至此，可以像使用gradlew一样来使用gradles了，比如
```
$ gradles assembleDebug --offline
$ gradles clean
```
编译完的apk放于当前工程根目录的```build/outputs/apk/```
