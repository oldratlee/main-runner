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
mvn install -P Profile-AllInOne
```

\# `-P Profile-AllInOne`选项开启打包操作。 关于Maven Profile参见：[Details on profile activation](http://maven.apache.org/guides/introduction/introduction-to-profiles.html)

会在`target`目录下生成`all-in-all.dir`目录，形如

```bash
├─bin # 运行脚本
│      env.sh
│      run.sh
│
├─conf # 配置文件，运行时会把这个conf目录加载到Class Path上
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

另外还会在`target`目录下生成一个`all-in-all.tar.gz`文件，是上面目录的压缩文件。

运行
----------------------

使用`target/all-in-all.dir/bin`目录下的`run.sh`脚本来运行，这个脚本的第一个参数是要运行的类，后面参数是Java的运行参数。

```bash
./run.sh com.oldratlee.runner.Main arg1 arg2
```

输出如下：

```bash
$ ./run.sh com.oldratlee.runner.Main arg1 arg2
===================================
Start run command:
D:\ProgFile\Java\jdk1.6.0_31/bin/java -cp E:\main-runner\target\all-in-one.dir\conf;E:\main-runner\target\all-in-one.dir\lib\hamcrest-core-1.3.jar;E:\main-runner\target\all-in-one.dir\lib\jakarta.commons.io-2.0.jar;E:\main-runner\target\all-in-one.dir\lib\jakarta.commons.lang-2.5.jar;E:\main-runner\target\all-in-one.dir\lib\junit-4.11.jar;E:\main-runner\target\all-in-one.dir\lib\log4j-1.2.17.jar;E:\main-runner\target\all-in-one.dir\lib\main.runner-0.0.1-SNAPSHOT.jar;E:\main-runner\target\all-in-one.dir\lib\slf4j-api-1.5.6.jar;E:\main-runner\target\all-in-one.dir\lib\slf4j-log4j12-1.5.6.jar; com.oldratlee.runner.Main arg1 arg2
===================================
2013-05-29 16:19:15,164 INFO [com.oldratlee.runner.Main] [main] (Main.java:13) - Hello World!
com.oldratlee.runner.Main run!
argument 0: arg1
argument 1: arg2
2013-05-29 16:19:15,167 INFO [com.oldratlee.runner.Main] [main] (Main.java:21) - Bye!
```

如何在你的工程加上打包的功能
----------------------------------

1. 在POM中加上：

```xml
<build>
	<plugins>
		<plugin>
			<groupId>org.apache.maven.plugins</groupId>
			<artifactId>maven-assembly-plugin</artifactId>
			<executions>
				<execution>
					<id>assemble</id>
					<goals>
						<goal>single</goal>
					</goals>
					<phase>package</phase>
				</execution>
			</executions>
			<configuration>
				<finalName>all-in-one</finalName>
				<appendAssemblyId>false</appendAssemblyId>
				<attach>false</attach>
			</configuration>
		</plugin>
	</plugins>
</build>

<profiles>
	<profile>
		<id>Profile-AllInOne</id>
		<build>
			<plugins>
				<plugin>
					<artifactId>maven-assembly-plugin</artifactId>
					<configuration>
						<descriptors>
							<descriptor>${basedir}/dev.xml</descriptor>
						</descriptors>
					</configuration>
				</plugin>
			</plugins>
		</build>
	</profile>
	<profile>
		<id>Profile-AllInOne-NoDir</id>
		<build>
			<plugins>
				<plugin>
					<artifactId>maven-assembly-plugin</artifactId>
					<configuration>
						<descriptors>
							<descriptor>${basedir}/release.xml</descriptor>
						</descriptors>
					</configuration>
				</plugin>
			</plugins>
		</build>
	</profile>
</profiles>
```

2. 添加文件`dev.xml`、release.xml`到工程目录

这2个文件到本工程提取即可。

3. 添加启动脚本目录`bin`到工程目录

这个目录到本工程提取即可。

4. 添加配置文件目录`conf`到工程目录

下面文件可以是你需要的配置文件。
