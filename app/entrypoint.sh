#!/bin/bash

/etc/init.d/redis-server start
cd ntopng && ./ntopng -i eth0 -w 0.0.0.0:3000 -d /workspace/data
