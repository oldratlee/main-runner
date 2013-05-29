Main Runner
========================

平时写了一个Java程序，会希望把应用打包来运行，最好是提供一个脚本来运行。

这个工程做的事情：

- 配置了maven-assembly-plugin Maven插件，把工程里用到的依赖的Jar放到一起。
- 提供了运行脚本。

打包
-------------------

在执行mvn install时，

```bash
mvn install
```

会在target下生成打包目录，形如

```bash
├─bin # 运行脚本
│      env.sh
│      run.sh
│
├─conf # 配置文件，运行时会被加载到Class Path上
│      foo.properties
│
└─lib # 相关的依赖
        jakarta.commons.io-2.0.jar
        jakarta.commons.lang-2.5.jar
        log4j-1.2.17.jar
        main.runner-0.0.1-SNAPSHOT.jar
        slf4j-api-1.5.6.jar
        slf4j-log4j12-1.5.6.jar
        ......
```

运行
----------------------

使用`run.sh`脚本来运行，这个参数是要运行的类，后面运行参数。

```bash
./run.sh com.foo.Main arg1 arg2
```


