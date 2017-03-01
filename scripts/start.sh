#!/bin/bash
if [ ! -f /home/Modules/Steam/steam/steamcmd/steamcmd.sh ]; then
    echo "Steamcmd n'existe pas sur cette machine !"
    wget -q -O /home/Modules/Steam/steam/steamcmd/steamcmd_linux.tar.gz http://media.steampowered.com/client/steamcmd_linux.tar.gz
    tar --directory /home/Modules/Steam/steam/steamcmd -xvzf /home/Modules/Steam/steam/steamcmd/steamcmd_linux.tar.gz
    rm /home/Modules/Steam/steam/steamcmd/steamcmd_linux.tar.gz
    chmod -R 774 /home/Modules/Steam/steam/steamcmd $SERVER_DIR
fi

echo "--- Mise à jour de SteamCMD ---"
/home/Modules/Steam/steam/steamcmd/steamcmd.sh \
    +login anonymous \
    +quit

echo "--- Mise à jour du serveur Steam ---"
/home/Modules/Steam/steam/steamcmd/steamcmd.sh \
    +login anonymous \
    +force_install_dir $SERVER_DIR \
    +app_update $GAME_ID \
    +quit

echo "--- Démarrage du serveur ---"
/home/Modules/Steam/steam/steamcmd/srcds_run -game $GAME_NAME -usercon -console $GAME_PARAMS +port $GAME_PORT +sv_lan 1