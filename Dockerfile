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
RUN apt-get -y install lib32gcc1 libc6-i386 wget

# Ajout de l'user Steam #
RUN sed -i.bkp -e \
	's/%sudo\s\+ALL=(ALL\(:ALL\)\?)\s\+ALL/%sudo ALL=NOPASSWD:ALL/g' /etc/sudoers \
	/etc/sudoers
RUN adduser \
	--disabled-login \
	--shell /bin/bash \
	--gecos "" \
	steam
RUN usermod -a -G sudo steam

# Copie des scripts
RUN mkdir /home
COPY steam.sh /home/steam/run.sh

# Dossier de script
RUN mkdir /home/Modules/Steam/steam/
RUN chmod -R 774 /home/Modules/Steam/steam/
ADD /scripts/ /home/Modules/Steam/steam/

# Téléchargement de SteamCMD
RUN cd $STEAMCMD_DIR &&\
	curl http://media.steampowered.com/installer/steamcmd_linux.tar.gz | tar -vxz

# Passage sous le volume du jeu
VOLUME  /game
WORKDIR /game

ENTRYPOINT ["/home/Modules/Steam/steam/start.sh"]