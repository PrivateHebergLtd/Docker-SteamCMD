# ==================
#  Steam Dockerfile
#   PrivateHeberg©
# ==================

FROM debian:8
MAINTAINER privateHeberg

# ==== Variables ==== #
ENV STEAM_USER anonymous
ENV STEAM_PASS ""
ENV GAME_ID=""
ENV GAME_NAME=""
ENV GAME_PARAMS=""
ENV GAME_PORT=27015
# =================== #

# ==== Paquets ==== #
RUN apt-get update
RUN apt-get -y install lib32gcc1 libc6-i386 wget curl
# ================= #

# ==== Steam user ==== #
RUN adduser \
	--disabled-login \
	--shell /bin/bash \
	--gecos "" \
	steam
RUN usermod -a -G sudo steam
# ==================== #

# ==== Scripts ==== #
RUN mkdir -p /data && mkdir -p /data/steamcmd
RUN chmod -R 777 /data
ADD start.sh /
RUN chmod -R 777 start.sh
# ================= #

# ==== Volumes ==== #
VOLUME /data
WORKDIR /data
# ================= #

CMD /start.sh