#!/bin/bash
if [ ! -f /data/steamcmd/steamcmd.sh ]; then
    echo "Steamcmd n'existe pas sur cette machine !"
    wget -q -O /data/steamcmd/steamcmd_linux.tar.gz http://media.steampowered.com/client/steamcmd_linux.tar.gz
    tar --directory /data/steamcmd/steamcmd -xvzf /data/steamcmd/steamcmd_linux.tar.gz
    rm /data/steamcmd/steamcmd_linux.tar.gz
    chmod -R 774 /data/steamcmd ${SERVER_DIR}
fi

echo "--- Mise à jour de SteamCMD ---"
/data/steamcmd/steamcmd.sh \
    +login anonymous \
    +quit

echo "--- Mise à jour du serveur Steam ---"
/data/steamcmd/steamcmd.sh \
    +login anonymous \
    +force_install_dir /data \
    +app_update ${GAME_ID} \
    +quit

echo "--- Démarrage du serveur ---"
cd /data && ./srcds_run -game ${GAME_NAME} -usercon -console ${GAME_PARAMS} +port ${GAME_PORT} +sv_lan 1