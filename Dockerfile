FROM debian:8
MAINTAINER privateHeberg

# Variables #
ENV DATA_DIR="/home/SERVERS/SERVER00BETA"
ENV STEAMCMD_DIR="/home/Modules/Steam/steam/steamcmd"
ENV SERVER_DIR="${DATA_DIR}/serverfiles"
ENV GAME_ID="740"
ENV GAME_NAME="csgo"
ENV GAME_PARAMS="+game_type 0 +game_mode 0 +mapgroup mg_active +map de_dust2"
ENV GAME_PORT=27015

# Mise à jour et installation des dépendences #
RUN apt-get update
RUN apt-get -y install lib32gcc1 libc6-i386 wget curl

# Ajout de l'user Steam #
RUN adduser \
	--disabled-login \
	--shell /bin/bash \
	--gecos "" \
	steam
RUN usermod -a -G sudo steam

# Copie des scripts
RUN mkdir -p /home && mkdir -p /home/SERVERS && mkdir -p $DATA_DIR && mkdir -p /home/Modules && mkdir -p /home/Modules/Steam && mkdir -p /home/Modules/Steam/steam && mkdir -p $STEAMCMD_DIR

# Dossier de script
RUN chmod -R 777 /home/Modules/Steam/steam/
ADD start.sh /game

# Passage sous le volume du jeu
VOLUME  /game
WORKDIR /game

ENTRYPOINT ["/game/start.sh"]