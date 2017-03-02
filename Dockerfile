FROM debian:8
MAINTAINER privateHeberg

RUN apt-get update
RUN apt-get -y install lib32gcc1 libc6-i386 wget

ENV DATA_DIR="/home/SERVERS/SERVERBETAcsgo"
ENV STEAMCMD_DIR="/home/Modules/Steam/steam/steamcmd"
ENV SERVER_DIR="${DATA_DIR}/serverfiles"
ENV GAME_ID="740"
ENV GAME_NAME="csgo"
ENV GAME_PARAMS="+game_type 0 +game_mode 0 +mapgroup mg_active +map de_dust2"
ENV GAME_PORT=27015

RUN mkdir /home/SERVERS
RUN mkdir /home/Modules && mkdir /home/Modules/Steam && mkdir /home/Modules/Steam/steam
RUN mkdir $STEAMCMD_DIR
RUN mkdir $DATA_DIR
RUN mkdir $SERVER_DIR

RUN ulimit -n 2048

ADD /scripts/ /home/Modules/Steam/steam/
RUN chmod -R 774 /home/Modules/Steam/steam/

ENTRYPOINT ["/home/Modules/Steam/steam/start.sh"]