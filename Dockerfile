FROM openjdk:8-alpine

WORKDIR /rlcraft
RUN apk add --no-cache git unzip wget

RUN wget https://hub.spigotmc.org/jenkins/job/BuildTools/lastSuccessfulBuild/artifact/target/BuildTools.jar
RUN java -jar BuildTools.jar --compile craftbukkit --rev 1.12.2

RUN wget https://maven.minecraftforge.net/net/minecraftforge/forge/1.12.2-14.23.5.2855/forge-1.12.2-14.23.5.2855-installer.jar
RUN java -jar forge-1.12.2-14.23.5.2855-installer.jar --installServer

RUN wget https://media.forgecdn.net/files/2935/323/RLCraft+Server+Pack+1.12.2+-+Beta+v2.8.2.zip
RUN unzip RLCraft+Server+Pack+1.12.2+-+Beta+v2.8.2.zip

ADD eula.txt .
ADD server.properties .

EXPOSE 25565
CMD [ \
  "java", \
  "-Xms4G", \
  "-Xmx8G", \
  "-XX:+UseG1GC", \
  "-XX:+ParallelRefProcEnabled", \
  "-XX:MaxGCPauseMillis=200", \
  "-XX:+UnlockExperimentalVMOptions", \
  "-XX:+DisableExplicitGC", \
  "-XX:+AlwaysPreTouch", \
  "-XX:G1NewSizePercent=30", \
  "-XX:G1MaxNewSizePercent=40", \
  "-XX:G1HeapRegionSize=8M", \
  "-XX:G1ReservePercent=20", \
  "-XX:G1HeapWastePercent=5", \
  "-XX:G1MixedGCCountTarget=4", \
  "-XX:InitiatingHeapOccupancyPercent=15", \
  "-XX:G1MixedGCLiveThresholdPercent=90", \
  "-XX:G1RSetUpdatingPauseTimePercent=5", \
  "-XX:SurvivorRatio=32", \
  "-XX:+PerfDisableSharedMem", \
  "-XX:MaxTenuringThreshold=1", \
  "-Dusing.aikars.flags=https://mcflags.emc.gs", \
  "-Daikars.new.flags=true", \
  "-jar", \
  "forge-1.12.2-14.23.5.2855.jar", \
  "nogui" \
]
