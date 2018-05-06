FROM bigtruedata/sbt

WORKDIR /sbt

RUN \
        mkdir -p project \
        && echo 'sbt.version = 1.1.2' > project/build.properties

RUN sbt sbtVersion
