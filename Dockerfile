FROM debian
MAINTAINER PrivateHeberg

RUN mkdir -p $dir
WORKDIR $dir
RUN wget http://media.steampowered.com/client/steamcmd_linux.tar.gz
RUN tar -xvzf steamcmd_linux.tar.gz

EXPOSE $port

WORKDIR $dir
ADD start.sh $dir/start.sh
RUN chmod 755 $dir/start.sh

CMD ["$dir/start.sh"]