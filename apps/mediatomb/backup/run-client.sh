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

NT=8
cd $MSMR_ROOT/apps/mediatomb

# Note: the -m $PWD option is for setting up the server with the
# config database MSMR_ROOT/apps/mediatomb/.mediatomb

#Heming: must not add the ld preload here because the eval-multimachine has already done this.
#LD_PRELOAD=$MSMR_ROOT/libevent_paxos/client-ld-preload/libclilib.so \
../../apps/apache/install/bin/ab -n $NT -c $NT \
http://$1:$2/content/media/object_id/8/res_id/none/pr_name/vlcmpeg/tr/1
