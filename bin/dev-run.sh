#!/bin/sh

#Move to the folder where ep-lite is installed
cd `dirname $0`

#Was this script started in the bin folder? if yes move out
if [ -d "../bin" ]; then
  cd "../"
fi

#Stop the script if its started as root
if [ "$(id -u)" -eq 0 ]; then
   echo "You shouldn't start Etherpad-Lite as root!"
   echo "'yay' if you still want to start it as root"
   read rocks
   if [ ! $rocks = "yay" ]
   then
     echo "Your input was incorrect"
     exit 1
   fi
fi

#prepare the enviroment
bin/installDeps.sh $* || exit 1

#Move to the node folder and start
echo "start..."
node node_modules/ep_etherpad-lite/node/server.js $*
