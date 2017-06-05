#!/usr/bin/env bash
echo "#######################################"
echo "#   PrivateHeberg© - Module Steam     #"
echo "#######################################"

# On va dans la parti. data
cd /data

# Dossier template pour stocker les dossier de config vanilla
[ ! -d /data/template ] && mkdir /data/template
# Copier les configs pour chaque jeu
# cp /home/steam/config.cfg /ark/template/config.cfg

# Création des dossiers
[ ! -d /data/log ] && mkdir /data/log
[ ! -d /data/backup ] && mkdir /data/backup
[ ! -d /data/game ] && mkdir /data/game

if [ ! -d /data/server  ] || [ ! -f /data/server ];then
	echo "Aucun fichier de jeu, installation...."
	mkdir -p /data/server
    # TODO Installation du jeu
fi

if [ ! -f /data/apikey.txt ]; then
    echo '' > /data/apikey.txt
fi
apikey=$(</data/apikey.txt)

ln -s /home/steam/steamcmd/linux32/steamclient.so ~/.steam/sdk32/steamclient.so

echo "--- Mise à jour de SteamCMD ---"
/home/steam/steamcmd/steamcmd.sh \
    +login anonymous \
    +quit

echo "--- Mise à jour du serveur Steam ---"
/home/steam/steamcmd/steamcmd.sh \
    +login anonymous \
    +force_install_dir /data/game \
    +app_update ${GAME_ID} \
    +quit

echo "--- Démarrage du serveur ---"
echo "Commande: ./srcds_run -game ${GAME_NAME} -debug -usercon -console ${GAME_PARAMS} +port ${GAME_PORT} +sv_setsteamaccount ${apikey}"
cd /data/game && ./srcds_run -game ${GAME_NAME} -debug -usercon -console ${GAME_PARAMS} +port ${GAME_PORT} +sv_setsteamaccount ${apikey}