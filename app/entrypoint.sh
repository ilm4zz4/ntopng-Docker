#!/bin/bash

WORKDIR=/workspace/data 

/etc/init.d/redis-server start

mkdir $WORKDIR
chown ntopng:ntopng $WORKDIR

ntopng -i eth0 -w 0.0.0.0:3000 -d $WORKDIR
