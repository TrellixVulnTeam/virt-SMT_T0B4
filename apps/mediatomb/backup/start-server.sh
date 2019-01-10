#!/bin/bash

if [ ! $1 ];
then
        echo "Usage: $0 <server IP> <server port>"
        echo "$0 127.0.0.1 7000"
        exit 1;
fi

if [ ! $2 ];
then
        echo "Usage: $0 <server IP> <server port>"
        echo "$0 127.0.0.1 7000"
        exit 1;
fi

MSMR_ROOT="build"

cd $MSMR_ROOT
killall -9 mediatomb server.out wget mencoder ab &> /dev/null
sleep 1
killall -9 mediatomb server.out wget mencoder ab &> /dev/null
rm -rf .db

# Note: the -m $PWD option is for setting up the server with the
# config database MSMR_ROOT/apps/mediatomb/.mediatomb

# Heming: must not add ldpreload here, because the run.sh has already done this with the wrap-xtern.sh
#LD_PRELOAD=$XTERN_ROOT/dync_hook/interpose.so \
./install/bin/mediatomb -i $1 -p $2 -m $PWD &> out.txt &
sleep 5
