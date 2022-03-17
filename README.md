# Lealone-Polyglot

使用 JavaScript 和 Python 语言在 Lealone 中开发微服务应用


## 需要

* JDK 1.8+
* Maven 3.3+
* GraalVM 22.0+ (运行 Python 应用需要它，参见最后一节)


## 打包

执行以下命令打包:

`mvn package assembly:assembly -Dmaven.test.skip=true`

生成的文件放在 `target\lealone-5.0.0-SNAPSHOT` 目录


## 运行 Lealone 数据库

进入 `target\lealone-5.0.0-SNAPSHOT\bin` 目录，运行: `lealone.sh`

```java
/home/test/lealone-polyglot/target/lealone-5.0.0-SNAPSHOT/bin>lealone.sh

INFO  22:10:47.016 Lealone version: 5.0.0-SNAPSHOT
INFO  22:10:47.024 Loading config from file:/home/test/lealone-polyglot/target/lealone-5.0.0-SNAPSHOT/conf/lealone.yaml
INFO  22:10:47.079 Base dir: ../data
INFO  22:10:47.090 Init storage engines: 8 ms
INFO  22:10:47.128 Init transaction engines: 36 ms
INFO  22:10:47.131 Init sql engines: 2 ms
INFO  22:10:47.228 Init protocol server engines: 94 ms
INFO  22:10:47.301 Init lealone database: 72 ms
INFO  22:10:47.302 Starting tcp server accepter
INFO  22:10:47.307 TcpServer started, host: 127.0.0.1, port: 9210
INFO  22:10:47.569 Web root: ../web
INFO  22:10:47.570 Sockjs path: /_lealone_sockjs_/*
INFO  22:10:47.571 HttpServer is now listening on port: 9000
INFO  22:10:47.574 HttpServer started, host: 127.0.0.1, port: 9000
INFO  22:10:47.575 Total time: 554 ms (Load config: 59 ms, Init: 223 ms, Start: 272 ms)
INFO  22:10:47.575 Exit with Ctrl+C
```

## 使用 JavaScript 开发微服务应用

/home/test/hello_service.js

```JavaScript
function hello(name) {
    return "hello " + name;
}
```

## 使用 Python 开发微服务应用

/home/test/hello_service.py

```Python
def hello(name):
    return "hello " + name;
```


## 在 Lealone 数据库中创建服务

打开一个新的命令行窗口，进入 `target\lealone-5.0.0-SNAPSHOT\bin` 目录，

运行: `sqlshell.sh -url jdbc:lealone:tcp://127.0.0.1:9210/lealone -user root`

执行以下 SQL 创建 js_hello_service

```java
create service js_hello_service (
  hello(name varchar) varchar
)
language 'js' implement by '/home/test/hello_service.js';
```

执行以下 SQL 创建 python_hello_service

```java
create service python_hello_service (
  hello(name varchar) varchar
)
language 'python' implement by '/home/test/hello_service.py';
```


## 通过 SQL 调用服务

execute service js_hello_service hello('zhh');

execute service python_hello_service hello('zhh');



## 通过 HTTP 调用服务

http://localhost:9000/service/js_hello_service/hello?name=zhh

http://localhost:9000/service/python_hello_service/hello?name=zhh


## 安装 GraalVM

运行 Python 应用需要事先安装 GraalVM，目前不支持 Windows

安装 GraalVM 请参考 https://www.graalvm.org/22.0/docs/getting-started/

这里假设安装后的目录是 /home/test/graalvm-ee-java17-22.0.0.2

接着配置一下 JAVA_HOME 和 PATH 环境变量

export JAVA_HOME=/home/test/graalvm-ee-java17-22.0.0.2

export PATH=$JAVA_HOME/bin:$PATH

最后还需要安装 Python 组件

gu install python

更多信息参考 https://www.graalvm.org/22.0/reference-manual/python/

