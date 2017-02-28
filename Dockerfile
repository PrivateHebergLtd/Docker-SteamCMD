FROM debian
MAINTAINER privateHeberg

RUN apt-get update
RUN apt-get -y install lib32gcc1 libc6-i386 wget

ENV DATA_DIR="/serverdata"
ENV STEAMCMD_DIR="${DATA_DIR}"
ENV SERVER_DIR="${DATA_DIR}"
ENV GAME_ID="740"
ENV GAME_NAME="csgo"
ENV GAME_PARAMS="+game_type 0 +game_mode 0 +mapgroup mg_active +map de_dust2"
ENV GAME_PORT=27015

RUN mkdir $DATA_DIR
RUN mkdir $STEAMCMD_DIR
RUN mkdir $SERVER_DIR

RUN ulimit -n 2048

ADD /scripts/ /opt/scripts/
RUN chmod -R 774 /opt/scripts/

ENTRYPOINT ["/opt/scripts/start.sh"]