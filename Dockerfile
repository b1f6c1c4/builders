FROM bigtruedata/sbt

WORKDIR /sbt

RUN \
        mkdir -p project \
        && echo 'sbt.version = 1.1.2' > project/build.properties \
        && echo 'scalaVersion := "2.11.12"' > build.sbt \
        && echo 'libraryDependencies += "org.apache.flink" % "flink-scala_2.11" % "1.4.2"' >> build.sbt \
        && echo 'libraryDependencies += "org.apache.flink" % "flink-streaming-scala_2.11" % "1.4.2"' >> build.sbt

RUN sbt compile

RUN \
        echo 'libraryDependencies += "org.apache.flink" % "flink-connector-rabbitmq_2.11" % "1.4.2"' >> build.sbt

RUN sbt compile
